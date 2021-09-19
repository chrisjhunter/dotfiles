# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. $HOME/.bashrc
fi

# User specific environment and startup programs


#[debian2 09:11:26 06/10/20] ~/minecraft/survival/MinecraftServer [0]$ grin GREP_OPTIONS ~/*
#grep: warning: GREP_OPTIONS is deprecated; please use an alias or script
#/home/chris/dotfiles/bash_profile:10:export GREP_OPTIONS='--color=always'
export PATH=~/bin:$PATH:$HOME/.local/bin
. "$HOME/.cargo/env"
