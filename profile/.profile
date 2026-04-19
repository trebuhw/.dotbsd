# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
