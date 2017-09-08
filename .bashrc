#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# source prompt definition
if [ -f .bash_prompt ]; then
	. .bash_prompt
fi

# source local definitions
# TODO move this to the end, to ensure local overrides all?
if [ -f .bashrc_local ]; then
	. .bashrc_local
fi

# User specific aliases and functions


#
# terminal
#


# enable 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

# disable ctrl-S (Flow Control)
stty -ixon


#
# locale
#


export LANG="en_CA.UTF-8"
export LC_ALL="en_CA.UTF-8"


#
# commands
#


# useful variables
export EDITOR='vim'
export PAGER='less'

# less with color-code support
export LESS=-R

# colorful grep
alias grep='grep --color=auto'

# vcs-less grep
alias vcsgrep='grep --exclude-dir=".svn"'

# useful ls
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -hl'
alias la='ls -Ahl'

# vim for view
alias view='vi -R'
