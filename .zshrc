# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

export EDITOR=nvim
export VISUAL=nvim
ZSH_THEME="refined"
# ZSH_THEME="cloud"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Aliases
alias m="meteor"
alias art="php artisan"
alias pest="./vendor/bin/pest"
alias pint="./vendor/bin/pint"
alias vapor="/Users/henrypercy/.composer/vendor/bin/vapor"

# Search and open session in TMUX
alias s='sesh connect "$(sesh list --icons | fzf --no-sort --ansi --height 40% --reverse --border-label " sesh " --border --prompt "⚡  ")"'

# make an authenticated request to chards API
alias chard="~/code/rework/scripts/request/chard.sh"

# find and copy the path to a directory 
alias cpd='echo -n $(fzf-tmux -p 40%,50% --walker=dir \
    --layout=reverse \
    --no-sort \
    --no-scrollbar --no-separator --prompt "" \
    --color "bg:#171B20,fg:#586172,fg+:#E7EAEE,bg+:#1E2430" \
    --color "hl:#5CCEFF,hl+:#5CCEFF,pointer:#38FFA5,prompt:#38FFA5" \
    --color "header:#586172,label:#5CCEFF,border:#586172" \
    --bind "tab:down,btab:up" \
    --no-preview \
    --no-info) | pbcopy'

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/user/.composer/vendor/bin:/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# bun completions
[ -s "/Users/henrypercy/.bun/_bun" ] && source "/Users/henrypercy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# golang
export GOPATH="$HOME/go"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Auto-start tmux with sesh
if command -v sesh &> /dev/null && [ -z "$TMUX" ]; then
  sesh connect "$(sesh list --icons | fzf --no-sort --ansi --height 40% --reverse --border-label " sesh " --border --prompt "⚡  ")" || tmux new -s main
fi

# edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

. "$HOME/.local/bin/env"

# zoxide setup
eval "$(zoxide init zsh)"


lsp-fetch() {
    local server="$1"
    local dest="${2:-$HOME/code/personal/dotfiles/.config/nvim/lsp}"

    if [[ -z "$server" ]]; then
        echo "Usage: lsp-fetch <server_name>"
        return 1
    fi

    curl -sL "https://raw.githubusercontent.com/neovim/nvim-lspconfig/master/lsp/${server}.lua" \
    -o "${dest}/${server}.lua" && echo "Saved to ${dest}/${server}.lua"
}

