alias vi='vim'
alias fuck='ls -lsh'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

export EDITOR="vi"
export TERM=xterm-256color
export PS1="\u:\W \\$ "
export SUDO_PS1="\u:\W \\$ "

eval "$(rbenv init -)"

ulimit -n 200000
ulimit -u 2048
