alias showoff=/Users/msantiago/.rvm/gems/ruby-1.9.2-p180/bin/show
alias hcvaws="ssh -i ~/Dropbox/zeroelink/dev/DevNCDKP.pem ubuntu@ec2-184-72-78-67.compute-1.amazonaws.com"
alias hcvprod="ssh -i ~/Dropbox/zeroelink/dev/hcvrails.pem ubuntu@ec2-184-73-109-58.compute-1.amazonaws.com"
alias loanappdb="ssh -i ~/Dropbox/zeroelink/dev/certs/DevNCDKP.pem -l ubuntu -L 33060:localhost:3306 -N ec2-107-20-101-178.compute-1.amazonaws.com"
# See following for more information: http://www.infinitered.com/blog/?p=10


# Identify OS and Machine -----------------------------------------
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"
# Note, default OS is assumed to be OSX

alias startjdev="/users/msantiago/oracle/middleware/jdeveloper/jdev/bin/jdev"

# rails shit
#export CC=/Developer/usr/bin/gcc-4.2


# Path ------------------------------------------------------------
if [ "$OS" = "darwin" ] ; then
  export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:$PATH  # OS-X Specific, with MacPorts and MySQL installed
  #export PATH=/opt/local/bin:/opt/local/sbin:$PATH  # OS-X Specific, with MacPorts installed
fi

if [ -d ~/bin ]; then
	export PATH=:~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi

if [ -d ~/cl/bin ]; then
	export PATH=:~/cl/bin:$PATH  # add your bin folder to the path, if you have it
fi



# Load in .bashrc -------------------------------------------------
source ~/.bashrc


# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
echo -e "${COLOR_BROWN}`bash --version`"
echo -ne "${COLOR_GRAY}Uptime: "; uptime
echo -ne "${COLOR_GRAY}Server time is: "; date


# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X,
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started
# (when you run "bash" from inside a shell, or when you start a shell in
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed,
# in this order:
#     bashrc
#     .bashrcsource ~/.git-completion.bash
source ~/.git-completion.bash

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

##
# Your previous /Users/msantiago/.bash_profile file was backed up as /Users/msantiago/.bash_profile.macports-saved_2011-04-10_at_16:59:43
##

# MacPorts Installer addition on 2011-04-10_at_16:59:43: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=$PATH:/Users/msantiago/Dropbox/zeroelink/dev/android-sdk-mac_x86/platform-tools:/Users/msantiago/.rvm/gems/ruby-1.9.2-p180/gems/showoff-io-0.3.0/bin:/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/A/Resources
export PATH=$HOME/local/node/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/msantiago/Dropbox/zeroelink/dev/git-hg/bin:$PATH
export NODE_PATH=$HOME/local/node/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## Added Postgres.app to PATH
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Load in nvm
#. ~/nvm/nvm.sh

# SqlPlus Stuff
# DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Applications/instantclient_10_2; export DYLD_LIBRARY_PATH
# TNS_ADMIN=/Applications/instantclient_10_2/network/admin; export TNS_ADMIN
# PATH=$PATH:/Applications/instantclient_10_2; export PATH

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
