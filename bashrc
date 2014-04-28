# An's bashrc 

HOME_NODE=$HOME/node_modules
alias cnpm="npm --registry=http://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=http://dist.cnpmjs.org \
--userconfig=$HOME/.cnpmrc"

alias fan=$HOME_NODE/fanyi/bin/fanyi
alias mocha=$HOME_NODE/mocha/bin/mocha
alias compound=$HOME_NODE/compound/bin/compound.js

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
# esac

if [ -d ~/.completion/ ]; then
  for file in ~/.completion/*
  do
    [ -f $file ] && . $file
  done
fi
# History Options
# ###############

# Don't put duplicate lines in the history.
# export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
# export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"


# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias c='clear'             # clear the screen easily

# Git aliases for bash
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'

# Some shortcuts for different directory listings
alias ls='ls -GhF'                 # classify files in colour
alias dir='ls --format=vertical'
alias vdir='ls --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias stb='ssh -p 60322 scudco@209.20.65.87'
alias sstb='screen -t telcobox.net 9 stb'
alias ql='qlmanage -p "$@" > /dev/null 2>&1'
alias qlt='qlmanage -p -c public.plain-text "$@" > /dev/null 2>&1'
alias screen='screen -T xterm-256color'
alias ss='screen -S'
alias screens='ss screens -c ~/.screens'
alias visor='ss visor -c ~/.visor_screens'

alias inbox='cd ~/Desktop/inbox'

alias gemi='sudo gem install --no-ri --no-rdoc'
function gemri() { sudo gem install "$@"; fastri-server --rebuild-index; }

alias rs='rake spec SPEC_OPTS=-c'

alias tlf='twitter timeline --force | less'
# Functions
# #########

# Some example functions
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

bind 'TAB:menu-complete'
export LSCOLORS=ExFxCxDxBxegedabagacad
export VISUAL='vim'
export SPEC_OPTS='-c'
