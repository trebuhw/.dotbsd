#
# .profile - Bourne Shell startup script for login shells
#
# see also sh(1), environ(7).
#

# Locale pl > możesz w terminalu wkleic i  sprwadzić polecenia
# terminal >  setenv LANG pl_PL.UTF-8
# terminal > setenv LC_ALL pl_PL.UTF-8

# Podstawowe
export LANG=pl_PL.UTF-8
export LC_ALL=pl_PL.UTF-8
export LC_CTYPE=pl_PL.UTF-8
export LC_MESSAGES=pl_PL.UTF-8

# Rozszeżone
# export LANG=pl_PL.UTF-8
# export LC_CTYPE="pl_PL.UTF-8"
#export LC_COLLATE="pl_PL.UTF-8"
# export LC_TIME="pl_PL.UTF-8"
# export LC_NUMERIC="pl_PL.UTF-8"
# export LC_MONETARY="pl_PL.UTF-8"
# export LC_MESSAGES="pl_PL.UTF-8"
# export LC_ALL=pl_PL.UTF-8

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
# PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/bin; export PATH

# Setting TERM is normally done through /etc/ttys.  Do only override
# if you're sure that you'll never log in via telnet or xterm or a
# serial line.
# TERM=xterm-256color; 	export TERM

EDITOR=nvim;	export EDITOR
VISUAL=nvim;  export VISUAL
PAGER=less;  	export PAGER

# set ENV to a file invoked each time sh is started for interactive use.
ENV=$HOME/.shrc; export ENV

# Let sh(1) know it's at home, despite /home being a symlink.
if [ "$PWD" != "$HOME" ] && [ "$PWD" -ef "$HOME" ] ; then cd ; fi

# Query terminal size; useful for serial lines.
if [ -x /usr/bin/resizewin ] ; then /usr/bin/resizewin -z ; fi

# Display a random cookie on each login.
if [ -x /usr/bin/fortune ] ; then /usr/bin/fortune freebsd-tips ; fi
