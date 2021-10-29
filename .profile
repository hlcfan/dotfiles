alias vi='nvim'
alias fuck='ls -lsh'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

export EDITOR="vi"
export CLICOLOR=1
export TERM=xterm-256color
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$HOME/.rbenv/bin:/Users/hlcfan/nvim/bin:$PATH"
export erl_aflags="-kernel shell_history enabled"

# export PS1="\u:\W \\$ "
# export SUDO_PS1="\u:\W \\$ "

eval "$(starship init zsh)"
eval "$(rbenv init -)"

ulimit -n 200000
ulimit -u 2048
