export CLICOLOR=1
PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH:$HOME/sandbox/cabify-tools

# setup rbenv
eval "$(rbenv init -)"

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

if [ $ITERM_SESSION_ID ]; then
    export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"'
fi
