export EDITOR=/usr/local/bin/subl

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$()]/"
}

# If running interactively, then:
if [ "$PS1" ]; then
    # history
    shopt -s histappend
    HISTCONTROL=ignoredups
    HISTIGNORE=ll:ls:l:jobs:fg:w:history:exit
    HISTFILESIZE=10000
    HISTSIZE=2000
    PROMPT_COMMAND='history -a'

    # enable color support for ls
    export LSCOLORS=gxfxcxdxbxegedabagacad
    alias ls='ls -G'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'

    # set a fancy prompt
    PS1='\u@\h:\w$(parse_git_branch)\$ '
    MYSQL_PS1='mysql [\h:\d]> '

    # bundler shortcuts
    alias be='bundle exec'
    alias bo='bundle open'

    # git
    alias g='git'
    alias gx='gitx'
    alias st='stree'

    # homebrew sync
    alias brew_sync='brew list | cat ~/.brew_formulae - | sort | uniq > ~/.brew_formulae && brew install `cat ~/.brew_formulae`'
fi

# raise maxfiles for riak
ulimit -n 8192
