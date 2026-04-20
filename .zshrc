# Machine-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

export EDITOR=nvim
export VISUAL=nvim

ZSH_THEME="refined"
plugins=(git)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Aliases
alias m="meteor"
alias art="php artisan"
alias pest="./vendor/bin/pest"
alias pint="./vendor/bin/pint"
alias s='sesh connect "$(sesh list --icons | fzf --no-preview)"'

# PATH
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" \
    --layout=reverse \
    --no-sort \
    --ansi \
    --no-scrollbar --no-separator --prompt '' \
    --color 'bg:#171B20,fg:#586172,fg+:#E7EAEE,bg+:#1E2430' \
    --color 'hl:#5CCEFF,hl+:#5CCEFF,pointer:#38FFA5,prompt:#38FFA5' \
    --color 'header:#586172,label:#5CCEFF,border:#586172' \
    --bind 'tab:down,btab:up' \
    --no-info"

# Edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Zoxide
eval "$(zoxide init zsh)"

