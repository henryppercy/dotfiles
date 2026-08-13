# Environment rules (non-negotiable)

This environment blocks entire command categories. Do not attempt them, and do not
try to work around the blocks.

- **No git or GitHub commands.** If you need a branch, diff, log, or commit, output
  the exact command in a code block and ask the user to run it.
- **No installs.** No npm/composer/pip/brew/etc. install or update commands. If a
  dependency is missing, tell the user exactly what to install.
- **No network commands.** No curl, wget, ssh, scp, etc. If you need something from
  the network, give the user the command or URL to fetch.
- **Only write inside the current working directory.**

When you need one of these: state the command, ask the user to run it, and continue
with whatever you can do yourself in the meantime.

Keep context small: locate with grep/find/ls first, then read specific files or
ranges. Do not load whole files or trees speculatively.

Style:

- **No em dashes or en dashes, ever.** Not in files, not in responses. 
