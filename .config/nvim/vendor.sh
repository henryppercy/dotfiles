#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENDOR_DIR="$SCRIPT_DIR/pack/vendor/opt"
TMP_DIR="/tmp/nvim-vendor"

# Plugin list: "github-org/repo directory-name"
PLUGINS=(
    "serhez/teide.nvim teide.nvim"
    "folke/snacks.nvim snacks.nvim"
    "folke/which-key.nvim which-key.nvim"
    "nvim-lualine/lualine.nvim lualine.nvim"
    "nvim-treesitter/nvim-treesitter nvim-treesitter"
    "neovim/nvim-lspconfig nvim-lspconfig"
    "rafamadriz/friendly-snippets friendly-snippets"
    "saghen/blink.lib blink.lib"
    "saghen/blink.cmp blink.cmp"
    "williamboman/mason.nvim mason.nvim"
    "stevearc/oil.nvim oil.nvim"
    "MeanderingProgrammer/render-markdown.nvim render-markdown.nvim"
    "shortcuts/no-neck-pain.nvim no-neck-pain.nvim"
    "lewis6991/gitsigns.nvim gitsigns.nvim"
    "folke/todo-comments.nvim todo-comments.nvim"
    "stevearc/conform.nvim conform.nvim"
    "windwp/nvim-ts-autotag nvim-ts-autotag"
    "YouSame2/inlinediff-nvim inlinediff-nvim"
    "falsycat/ledger.nvim ledger.nvim"
    "wllfaria/ledger.nvim wllfaria-ledger.nvim"
    "Saghen/blink.compat blink.compat"
)

clone_plugin() {
    local repo="$1"
    local name="$2"
    local dest="$TMP_DIR/$name"

    rm -rf "$dest"
    echo "  Cloning $repo..."
    git clone --depth 1 --quiet "https://github.com/$repo.git" "$dest"
    rm -rf "$dest/.git"
}

vendor_all() {
    echo "Vendoring all plugins into $VENDOR_DIR"
    mkdir -p "$VENDOR_DIR"
    rm -rf "$TMP_DIR"
    mkdir -p "$TMP_DIR"

    for entry in "${PLUGINS[@]}"; do
        local repo="${entry%% *}"
        local name="${entry##* }"

        clone_plugin "$repo" "$name"
        rm -rf "$VENDOR_DIR/$name"
        cp -r "$TMP_DIR/$name" "$VENDOR_DIR/$name"
        echo "  ✓ $name"
    done

    rm -rf "$TMP_DIR"
    echo ""
    echo "Done. All plugins vendored."
}

update_plugin() {
    local repo="$1"
    local name="$2"

    if [ ! -d "$VENDOR_DIR/$name" ]; then
        echo "  $name not vendored yet — installing fresh"
        clone_plugin "$repo" "$name"
        cp -r "$TMP_DIR/$name" "$VENDOR_DIR/$name"
        echo "  ✓ $name installed"
        return
    fi

    clone_plugin "$repo" "$name"

    echo ""
    echo "=== Changes for $name ==="
    if diff -rq "$VENDOR_DIR/$name" "$TMP_DIR/$name" --exclude='.git' > /dev/null 2>&1; then
        echo "  No changes."
        return
    fi

    diff -r "$VENDOR_DIR/$name" "$TMP_DIR/$name" --exclude='.git' | head -100
    echo ""
    echo "  (showing first 100 lines of diff)"
    echo ""

    read -rp "  Apply update for $name? [y/N] " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        rm -rf "$VENDOR_DIR/$name"
        cp -r "$TMP_DIR/$name" "$VENDOR_DIR/$name"
        echo "  ✓ $name updated"
    else
        echo "  ✗ $name skipped"
    fi
}

update() {
    local filter="${1:-}"
    rm -rf "$TMP_DIR"
    mkdir -p "$TMP_DIR"

    for entry in "${PLUGINS[@]}"; do
        local repo="${entry%% *}"
        local name="${entry##* }"

        if [ -n "$filter" ] && [ "$name" != "$filter" ]; then
            continue
        fi

        update_plugin "$repo" "$name"
    done

    rm -rf "$TMP_DIR"
}

case "${1:-}" in
    update)
        update "${2:-}"
        ;;
    *)
        vendor_all
        ;;
esac
