bindkey -v
bindkey "^R" history-incremental-search-backward
source <($HOME/bin/fzf --zsh)

alias vi='nvim'
alias fuck='ls -lsh'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

export EDITOR="nvim"
export CLICOLOR=1
export TERM=xterm-256color
export HOMEBREW_NO_AUTO_UPDATE=1
export TERM=wezterm

export PATH="$HOME/go/bin:$HOME/.rbenv/bin:$HOME/neovim/bin:$HOME/node/bin:$HOME/.config/emacs/bin:$HOME/bin:$HOME/ziglang:$PATH"
export erl_aflags="-kernel shell_history enabled"

# export PS1="\u:\W \\$ "
# export SUDO_PS1="\u:\W \\$ "

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"
. "$HOME/.cargo/env"

ulimit -n 200000
ulimit -u 2048
