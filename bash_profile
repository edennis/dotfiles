export CLICOLOR=1
PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH

# setup rbenv
eval "$(rbenv init -)"

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
