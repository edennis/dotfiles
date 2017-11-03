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

    # Git branch bash completion
    if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash

      # Add git completion to aliases
      __git_complete g __git_main
      __git_complete gg _git_grep

      alias g='git'
      alias gg='git grep'
    fi

    # docker bash completion
    if [ -f ~/.docker-completion.bash ]; then
      . ~/.docker-completion.bash
    fi

    alias gx='gitx'

    # homebrew sync
    alias brew_sync='brew list | cat ~/.brew_formulae - | sort | uniq > ~/.brew_formulae && brew install `cat ~/.brew_formulae`'

    export GOPATH="$HOME/sandbox/go"
    PATH=$PATH:$GOPATH/bin

    # enable history for erlang/elixir
    export ERL_AFLAGS="-kernel shell_history enabled"

    # cabify birdseye
    export RESOLVE_DISABLE_WATCHERS=true

    alias sen='docker run -v /var/run/docker.sock:/run/docker.sock -ti -e TERM tomastomecek/sen'
fi

# raise maxfiles for riak
ulimit -n 8192

# ssh host completion
_ssh() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh
