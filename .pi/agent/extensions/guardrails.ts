/**
 * Guardrails Extension
 *
 * Policy layer for the security model
 * The agent proposes dangerous commands; the human runs them.
 *
 *   bash:       no git/gh, no installs, no network tools, no destructive patterns
 *   write/edit: scoped to the directory pi was opened in
 *
 * This is a UX/policy layer, NOT a security boundary - should be enforced by VM.
 * Block reasons deliberately instruct the agent to hand the command to the user.
 */

import path from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const ASK =
  "Do not retry or work around this. Output the exact command for the user to run themselves, then continue with whatever you can do.";

const GIT_TOOLS = ["git", "gh"];

const NETWORK_TOOLS = [
  "curl",
  "wget",
  "ssh",
  "scp",
  "sftp",
  "rsync",
  "nc",
  "ncat",
  "netcat",
  "telnet",
  "ftp",
  "ping",
];

const DESTRUCTIVE_TOKENS = ["sudo", "mkfs", "shutdown", "reboot"];

/**
 * Matches a command name at the start of a shell segment - after start,
 * whitespace, ; | & ( or backtick - with an optional path prefix.
 * Names are alphanumeric/hyphen only, so no regex escaping needed.
 */
function runsAny(command: string, names: string[]): boolean {
  for (const name of names) {
    const re = new RegExp(
      "(?:^|[\\s;|&(`])(?:[\\w.~/+-]*/)?" + name + "(?=\\s|$)",
    );
    if (re.test(command)) return true;
  }
  return false;
}

function checkInstall(command: string): string | undefined {
  const pmMatch = command.match(
    /(?:^|[\s;|&(`])(?:[\w.~/+-]*\/)?(npm|pnpm|yarn|bun)\s+(install|i|ci|add|remove|uninstall|update)(?=\s|$)/,
  );
  if (pmMatch) return `${pmMatch[1]} ${pmMatch[2]}`;

  const others: Array<[string, string]> = [
    ["composer", "(?:install|require|update|remove)"],
    ["pip3?", "install"],
    ["uv", "(?:add|pip\\s+install)"],
    ["brew", "install"],
    ["apt(?:-get)?", "install"],
    ["pacman", "-S"],
    ["gem", "install"],
    ["cargo", "install"],
  ];
  for (const [tool, sub] of others) {
    const re = new RegExp(
      "(?:^|[\\s;|&(`])(?:[\\w.~/+-]*/)?" + tool + "\\s+" + sub + "(?=\\s|$)",
    );
    if (re.test(command)) return `${tool} ${sub}`;
  }
  return undefined;
}

function checkDestructive(command: string): string | undefined {
  if (runsAny(command, DESTRUCTIVE_TOKENS)) return "sudo/mkfs/shutdown";
  if (/\bdd\s[^;&|]*\bof=/.test(command)) return "dd of=";
  if (/>>?\s*(~|\$HOME)\//.test(command)) return "redirect into home directory";

  // rm with a recursive flag: allowed for relative targets inside cwd
  // (accepted risk - git is the undo), blocked for anything escaping it.
  for (const segment of command.split(/[;&|]+/)) {
    const m = segment.trim().match(/^(?:[\w.~/+-]*\/)?rm\s+(.*)$/);
    if (!m) continue;
    const tokens = m[1].split(/\s+/).filter(Boolean);
    const recursive = tokens.some((t) => /^-[^\s-]*[rR]/.test(t));
    if (!recursive) continue;
    const escapes = tokens
      .filter((t) => !t.startsWith("-"))
      .some(
        (t) =>
          t === "/" ||
          t === "*" ||
          t.startsWith("/") ||
          t.startsWith("~") ||
          t.includes(".."),
      );
    if (escapes) return "recursive rm outside cwd";
  }
  return undefined;
}

export default function (pi: ExtensionAPI) {
  const root = process.cwd();

  pi.on("session_start", async (_event, ctx) => {
    ctx.ui.setStatus("guardrails", ctx.ui.theme.fg("accent", "guardrails"));
  });

  pi.on("tool_call", async (event) => {
    if (event.toolName === "bash") {
      const command = (event.input as { command?: string }).command ?? "";

      if (runsAny(command, GIT_TOOLS)) {
        return {
          block: true,
          reason: `[guardrails] agents never run git/GitHub commands. ${ASK}`,
        };
      }
      const install = checkInstall(command);
      if (install) {
        return {
          block: true,
          reason: `[guardrails] agents never run installs (${install}). ${ASK}`,
        };
      }
      if (runsAny(command, NETWORK_TOOLS)) {
        return {
          block: true,
          reason: `[guardrails] agents never run network commands. ${ASK}`,
        };
      }
      const destructive = checkDestructive(command);
      if (destructive) {
        return {
          block: true,
          reason: `[guardrails] destructive pattern blocked (${destructive}). ${ASK}`,
        };
      }
      return;
    }

    if (event.toolName === "write" || event.toolName === "edit") {
      const inputPath = (event.input as { path?: string }).path;
      if (!inputPath) return;
      // Lexical check only - symlinks are not resolved. Gondolin makes this hard.
      const resolved = path.resolve(root, inputPath);
      if (resolved !== root && !resolved.startsWith(root + path.sep)) {
        return {
          block: true,
          reason: `[guardrails] writes are scoped to ${root}. ${ASK}`,
        };
      }
    }
  });
}
