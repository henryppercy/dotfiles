/**
 * No Em Dashes
 *
 * Style layer: em/en dashes are banned in favour of hyphens.md).
 *
 *   write/edit:  block if the NEW content contains a dash; the agent rewrites and
 *                retries. Only new content is checked, so matching an existing dash
 *                in edit's oldText still works.
 *   message_end: rewrite assistant text as a safety net (dashes -> hyphens).
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const DASH = /[—–]/;
const DASHES = /[—–]/g;

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event) => {
    if (event.toolName !== "write" && event.toolName !== "edit") return;
    const input = event.input as { content?: unknown; newText?: unknown };
    const added = [input.content, input.newText].filter(
      (v): v is string => typeof v === "string",
    );
    if (added.some((s) => DASH.test(s))) {
      return {
        block: true,
        reason:
          "[style] em/en dashes are banned. Rewrite using hyphens, commas, or full stops, then retry.",
      };
    }
  });

  pi.on("message_end", async (event) => {
    const msg = event.message;
    if (msg.role !== "assistant" || !Array.isArray(msg.content)) return;
    let changed = false;
    const content = msg.content.map((block) => {
      if (block.type === "text" && DASH.test(block.text)) {
        changed = true;
        return { ...block, text: block.text.replace(DASHES, "-") };
      }
      return block;
    });
    if (changed) return { message: { ...msg, content } };
  });
}
