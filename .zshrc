# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cloud"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Aliases
alias art="php artisan"
alias vapor="/Users/henrypercy/.composer/vendor/bin/vapor"
alias io="~/code/tmux-session/tmux_io.sh ~/code/tmux-session/work.yaml"

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

# Herd injected PHP binary.
export PATH="/Users/henrypercy/Library/Application Support/Herd/bin/":$PATH
# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/henrypercy/Library/Application Support/Herd/config/php/82/"
# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/henrypercy/Library/Application Support/Herd/config/php/83/"
# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/henrypercy/Library/Application Support/Herd/config/php/84/"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. "$HOME/.local/bin/env"

