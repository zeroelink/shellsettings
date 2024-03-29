#alias reloadbash='source ~/cl/etc/bash_profile'
source ~/.git-completion.bash

export DISABLE_AUTO_TITLE="true"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#Magick Home Shit
# export MAGICK_HOME=~/Documents/dev/ImageMagick-6.7.4
# export PATH=$MAGICK_HOME/bin:$PATH
# export PATH=$MAGICK_HOME/bin:$PATH

# Wordwrap off
#alias wrap_off='set echo_style=both; echo -n "e[?7l"'
#alias wrap_on='set echo_style=both; echo -n "e[?7h"'

# Colors ----------------------------------------------------------
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ "$OS" = "linux" ] ; then
  alias ls='ls --color=auto' # For linux, etc
  # ls colors, see: http://www.linux-sxs.org/housekeeping/lscolors.html
  export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'  #LS_COLORS is not supported by the default ls command in OS-X
else
  alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
fi

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
#export COLOR_GREEN='\033[0;32m\]'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
#export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors



# History ----------------------------------------------------------
export HISTCONTROL=erasedups:ignoredups
export HISTFILESIZE=3000
#export HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll:lla:hf"
export HISTIGNORE="&:ls*:ls:[bf]g:exit:pwd:clear:mount:umount:[ \t]*:hf*:cd*"
alias h=history
hf(){
  grep "$@" ~/.bash_history
}



# Misc -------------------------------------------------------------
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Use vi command mode
#bind "set editing-mode vi"
#set -o vi
#bind -m vi-command -r 'v'

# git completion
#source ~/cl/bin/git-completion.bash

# Prompts ----------------------------------------------------------
#git_dirty_flag() {
  #git status 2> /dev/null | grep -c : | awk '{if ($1 > 0) print "⚡"}'
#}

function proml {
local BLUE="\[\033[0;34m\]"
local COLOR_GREEN="\[\033[0;32m\]"
local COLOR_GRAY="\[\033[1;30m\]"
local RED="\[\033[0;31m\]"
local LIGHT_RED="\[\033[1;31m\]"
local WHITE="\[\033[1;37m\]"
local NO_COLOUR="\[\033[0m\]"
case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="${COLOR_GREEN}zeroelink\
${COLOR_GRAY}$(__git_ps1)\
$WHITE\$$NO_COLOUR "
PS2='> '
PS4='+ '
}

prompt_func() {
    previous_return_value=$?;
    prompt="${COLOR_GREEN}zeroelink${COLOR_GRAY}$(__git_ps1)${COLOR_NC}\[\033]0;\u@\h: \w\007\] "
    #prompt="${COLOR_GREEN}\w${COLOR_NC}$(__git_ps1)${COLOR_YELLOW}$(git_dirty_flag)${COLOR_NC} "

    if test $previous_return_value -eq 0
    then
        PS1="${prompt}➔ "
    else
        PS1="${prompt}${COLOR_RED}➔ ${COLOR_NC}"
    fi
}
PROMPT_COMMAND=proml

# export PS1="\[${COLOR_GREEN}\]\w\[${COLOR_NC}\] > "  # Primary prompt with only a path
# export PS1="\[${COLOR_RED}\]\w > \[${COLOR_NC}\]"  # Primary prompt with only a path, for root, need condition to use this for root
# export PS1="\[${COLOR_GRAY}\]\u@\h \[${COLOR_GREEN}\]\w > \[${COLOR_NC}\]"  # Primary prompt with user, host, and path
# This runs before the prompt and sets the title of the xterm* window.  If you set the title in the prompt
# weird wrapping errors occur on some systems, so this method is superior
#export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/} ${USER}@${HOSTNAME%%.*}"; echo -ne "\007"'  # user@host path

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

function xt {  # change the title of your xterm* window
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007"
}



# Navigation -------------------------------------------------------
alias ..='cd ..'
alias ...='cd .. ; cd ..'
cl() { cd $1; ls -la; }

# I got the following from, and mod'd it: http://www.macosxhints.com/article.php?story=20020716005123797
#    The following aliases (save & show) are for saving frequently used directories
#    You can save a directory using an abbreviation of your choosing. Eg. save ms
#    You can subsequently move to one of the saved directories by using cd with
#    the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
  touch ~/.dirs
fi

alias showdirs='cat ~/.dirs'
save (){
  command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}  #"
remove () {
  command sed "/$1=/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; source ~/.dirs;
}  #"
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility



# Editors ----------------------------------------------------------
#export EDITOR='mate -w'  # OS-X SPECIFIC - TextMate, w is to wait for TextMate window to close
#export EDITOR='gedit'  #Linux/gnome
export EDITOR='vim'  #Command line
export GIT_EDITOR='vim'
#alias gvim='/Applications/MacVim.app/Contents/MacOS/vim -g'
alias v=vim
# Use mvim in cl/bin to open MacVim



# Security ---------------------------------------------------------

# Folder shared by a group
# chmod g+s directory
#find /foo -type f -print | xargs chmod g+rw,o-rwx,u+rw
#find /foo -type d -print | xargs chmod g+rwxs,o-rwx,u+rwx

# this might work just the same (not tested)
# chmod -R g+rwXs,o-rwx,u+rwX /foo



# Sluething----------------------------------------------------
findportuser() {
    lsof -i :"$1"
}



# Other aliases ----------------------------------------------------
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Search
alias g='grep -i'  # Case insensitive grep
gns(){ # Case insensitive, excluding svn folders
  find . -path '*/.svn' -prune -o -type f -print0 | xargs -0 grep -I -n -e "$1"
}
alias f='find . -iname'

# Misc
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder

if [ "$OS" = "linux" ] ; then
	alias processes_all='ps -aulx'
else
	alias top='top -o cpu' # os x
fi

alias flush="dscacheutil -flushcache" # Flush DNS cache

pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

zap () {
    open -a AppZapper /Applications/"${1}".app
}

tman () {
  MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}

bman () {
  MANWIDTH=160 MANPAGER='col -bx' man $@ | bbedit
}

alias systail='tail -f /var/log/system.log'
alias m='more'
alias rak='rak -a'

alias df='df -h' # Show disk usage

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias untar="tar xvzf"

alias cp_folder="cp -Rpv" #copies folder and all sub files and folders, preserving security and dates

kh() {
    kill -9 "$1"
}

# $1 = type; 0 - both, 1 - tab, 2 - title
# rest = text

# Rails Stuff
alias rors='rails server'
alias rorc='rails console'

rpi() {
	rails plugin install "$1"
}

ginstall() {
	sudo rvm 1.9.2-p290@rails3077 gem install "$1"
}

guninstall() {
	sudo rvm 1.9.2-p290@rails3077 gem uninstall "$1"
}

# Git Stuff
guntrack() {
	git rm --cached "$1"
}

# Bring in the other files ----------------------------------------------------
#source ~/.bashrc_help
#source ~/.bashrc_app_specific
if [ -f ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi


# Test ------------------------------------------------------------------------

#if [ "$OS" = "linux" ] ; then
#elif
#else
#fi

#if [ -z "$PS1" ]; then
  #echo 'non-interactive shell'
  ### non-interactive shells (only)
#else
  #echo 'interactive shell'
  ### interactive shells (only)
#fi
export LESS=-RFX

c() { cd ~/Dropbox/zeroelink/$1;  }



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
