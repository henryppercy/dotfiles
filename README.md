# Dotfiles

Shared dotfiles for macOS and Arch Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone  ~/code/personal/dotfiles
cd ~/code/personal/dotfiles
stow -t ~ .
```

Machine-specific config lives in `~/.zshrc.local` (not tracked by git). Copy the appropriate template after stowing:

- **Mac:** `cp .zshrc.local.mac ~/.zshrc.local`
- **Arch:** `cp .zshrc.local.arch ~/.zshrc.local`

## Shared

- [Neovim](https://github.com/neovim/neovim)
- [Ghostty](https://github.com/ghostty-org/ghostty)
- [Tmux](https://github.com/tmux/tmux/wiki)

## macOS

- [Aerospace](https://github.com/nikitabobko/AeroSpace)

## Arch Linux

- [Sway](https://github.com/swaywm/sway)
- [Waybar](https://github.com/Alexays/Waybar)
- [Swaylock](https://github.com/swaywm/swaylock)
- [Mako](https://github.com/emersion/mako)
- [sway-launcher-desktop](https://github.com/Biont/sway-launcher-desktop)

