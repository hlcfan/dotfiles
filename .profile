bindkey -v
bindkey "^R" history-incremental-search-backward

alias vi='nvim'
alias fuck='ls -lsh'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

export EDITOR="vi"
export CLICOLOR=1
export TERM=xterm-256color
export HOMEBREW_NO_AUTO_UPDATE=1
export TERM=wezterm

export PATH="$HOME/.rbenv/bin:/Users/hlcfan/nvim/bin:/Users/hlcfan/bin:/Users/hlcfan/go/bin:$PATH"
export erl_aflags="-kernel shell_history enabled"

# export PS1="\u:\W \\$ "
# export SUDO_PS1="\u:\W \\$ "

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"

ulimit -n 200000
ulimit -u 2048
