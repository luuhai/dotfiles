# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#osx color terminal
export CLICOLOR=1
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

HISTSIZE=2000
HISTFILESIZE=4000

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\033[01;31m\]\w\[\033[00m\]'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Set up TERM variables.
# vt100 and xterm have no color in vim (at least on unixs), but if we call them xterm-color, they will.
# (vt100 for F-Secure SSH.)
# This may well be the case for some other terms, so I'm putting them here.
# Also set up a variable to indicate whether to set up the title functions.
# TODO gnome-terminal, or however it reports itself
case $TERM in

  screen)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
  ;;

  xterm-color|color_xterm|rxvt|Eterm|screen*) # screen.linux|screen-w
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
  ;;

  linux)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=false
  ;;

  xterm|vt100)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
  ;;

  *xterm*|eterm|rxvt*)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
  ;;

  *)
    TERM_IS_COLOR=false
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=false
  ;;

esac

# dircolors... make sure that we have a color terminal, dircolors exists, and ls supports it.
if $TERM_IS_COLOR && ( dircolors --help && ls --color ) &> /dev/null; then
  # For some reason, the unixs machines need me to use $HOME instead of ~
  # List files from highest priority to lowest.  As soon as the loop finds one that works, it will exit.
  for POSSIBLE_DIR_COLORS in "$HOME/.dir_colors" "/etc/DIR_COLORS"; do
    [[ -f "$POSSIBLE_DIR_COLORS" ]] && [[ -r "$POSSIBLE_DIR_COLORS" ]] && eval `dircolors -b "$POSSIBLE_DIR_COLORS"` && break
  done

  alias ls="ls --color=auto"
  alias ll="ls --color=auto -l"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  # No color, so put a slash at the end of directory names, etc. to differentiate.
  alias ls="ls -F"
  alias ll="ls -lF"
fi
[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal)
{
  [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
    if ldd /proc/$PPID/exe | grep libvte; then
      if [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color-it
      elif [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color-it
      elif tput -T xterm; then
        TERM=xterm
      fi
    fi
  }
} >/dev/null 2>/dev/null

venwrap=`type -P virtualenvwrapper.sh`
if [ "$venwrap" != "" ]; then
    source $venwrap
fi

vim=`type -P vim`
if [ "$vim" == "" ]; then
    vim="gvim -v"
fi

alias vim="$vim"
alias eat="cd /home/hailt/code/mmj/eatout"
alias kuiso="cd /home/hailt/code/docker/kuiso/service-office-hanoi"
alias railsmon="htop -p \$(ps -ef | grep \"[r]ails s\" | awk '{print \$2}')"

# osx vim
if [ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
    PATH=/Applications/MacVim.app/Contents/MacOS/:$PATH
fi

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

parse_git_branch ()
{
  git branch 2> /dev/null | grep '*' | sed 's#*\ \(.*\)#(git::\1)#'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
set -o emacs
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# Add git and svn branch names
export PS1="$PS1\n\$(parse_git_branch)\$(parse_svn_branch)\n"
export PS1="$PS1\${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\[\033[01;36m\]\h\[\033[00m\]\$  "
source ~/.rvm/scripts/rvm
# source ~/code/virtualenv/bin/activate
# alias vim="nvim"
# alias ovim="/usr/bin/vim"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add this line to fix the bug: new tab is not opened in the same location as previous tab
. /etc/profile.d/vte.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

PATH="/home/hailt/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/hailt/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hailt/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hailt/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hailt/perl5"; export PERL_MM_OPT;

transfer() {
    tmpfile=$( mktemp -t transferXXX )
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9]/-/g')
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}

alias transfer=transfer

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code/go_work
