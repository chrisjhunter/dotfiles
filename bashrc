# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

###############Sensible bash################
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
#$if Bash
  #bind Space:magic-space
#$endif
#bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '
################me from random##########################
# bash cli behaves like vi
#set -o vi

#helps screen inherit, works on modern terms
export TERM=xterm-256color
#export TERM=screen-256color

#alias f="find . \"*$1*\""
f() {
    find . -iname "*$1*"
}

function ago() {
    #find . -maxdepth 2 -iname "*.go" -exec vi {} \; 2>/dev/null
    vim $(find . -not \( -path ./vendor -prune \) -iname "*.go")
    #vim $(find . -maxdepth 3 -iname "*.go")
    #vim `find . -maxdepth 2 -iname "*.go"`

    #set -x     Print command traces before executing command.
    #set -o
    #set -v     Prints shell input lines as they are read.
    #http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_03.html
    #https://www.gnu.org/software/bash/manual/bashref.html#The-Set-Builtin
}
################from sleuth###################
gp() {
    BRANCH=$(git symbolic-ref --short HEAD)
    REMOTE=$(git status -sb | grep '...origin')
    if [ -z "$REMOTE" ] 
    then
        git push --set-upstream origin $BRANCH
    else
        git push
    fi
}

gofind() {
    grep $2 $(find . -type f -name \*$1)
}


alias godocweb='godoc -http=:6060' # Spawns a godoc web server
alias ports='sudo lsof -i -P -n | sort -f '   # Displays all processes that are serving or listening on ports, sorted alphabetically

################from sclark###################
export HISTSIZE=10000                              # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
export HISTCONTROL=ignoreboth                      # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -lath'
#HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'         #dunno
export HISTIGNORE

################me from random###################
# User specific aliases and functions
alias ll="ls -lath --color"
alias lr="ls -lRath --color"
alias lss="ls -laSh --color"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -vi"
alias rmf="rm -v"
alias mkdir='mkdir -pv'                  # -p creates parent directories as needed, -v ouputs to console when it does
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias ..3='cd ../../../'                     # Go back 3 directory levels
alias ..4='cd ../../../../'                  # Go back 4 directory levels
alias ..5='cd ../../../../../'               # Go back 5 directory levels
alias ..6='cd ../../../../../../'            # Go back 6 directory levels
alias hs="history | grep"
#alias grep="grep --ignore-case --color --exclude-dir={.git,.svn,honnef.co,golang.org,github.com,code.google.com,gopkg.in,9fans.net} --exclude=.session.vim"
alias grep="grep --ignore-case --color --exclude-dir={.git,.svn,honnef.co,golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor} --exclude=.session.vim"
alias ggrep="grep --exclude-dir={golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor}"
alias brd="diff -y <(git log --oneline ) <(git log --oneline master) |head -20"
alias gsc="sub-status"
#alias ago="vim **/*.go"
alias lb="ls -lath ~/.vim/bundle/"
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"
########################https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
####################### hackernews
alias gs="git status"
alias gd='git diff --stat -w'      # Shows file changes
alias gda="git diff"
alias gac="git commit -am "
alias gca='git commit --amend'     # Amends the most recent commit
alias gc="git commit"
alias gcm="git commit -m"
alias gb="git blame"
#alias gl="git log"
#alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
#alias gla='git log --all --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
#custom from me
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gla='git log --all --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gls="git log  --pretty='format:%h %Cred%d %C(yellow)%ad%Creset %ae %Cgreen%s%Creset' --graph"
#alias gp="git push"
#alias gA="git add -A"
#alias gC="git checkout"
alias gco='git checkout'           # Checkout a branch or file
alias mast='git checkout master'           # Checkout master branch
alias brv='git branch -vvr'           # Checkout master branch
alias ga="git add"
alias gm="git merge"
alias gmc="git merge --continue"
alias gpu="git pull"
alias grc="git rebase --continue"

#####################more hackernews#####################
    #alias g='git status -sb'
    #alias ga='git add'
    #alias gac='git commit --amend'
    #alias gb='git branch'
    #alias gbb='git checkout -b'
    #alias gbm='git branch --merged'
    #alias gbn='git branch --no-merged'
    #alias gc='git commit -m'
    #alias gcp='git cherry-pick'
    #alias gco='git checkout'
    #alias gd='git diff'
    #alias gdc='git diff --cached'
    #alias gg='git status'
    #alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
    #alias gla='git log --all --graph --pretty=format:"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
    #alias ggpublish='git push && git push --tags && npm publish'
    #alias gp='git pull --rebase && git push'
    #alias gpp='git push && git push --tags'
    #alias gpl='git pull --rebase --prune'
    #alias gpt='git pull --rebase && git push --tags'
    #alias grb='git rebase'
    #alias grc='git rebase --continue'
    #alias gsp='git stash ; gp ; git stash pop'
    #alias unfuckgitremote='git branch --set-upstream-to=origin/`git rev-parse --abbrev-ref HEAD` `git rev-parse --abbrev-ref HEAD`'

#####################ZSH like PS1 below#####################
# moved to ~/.inputrc
#bind 'set completion-ignore-case on'
# Regular Colors
Black="\[\033[0;30m\]"      # Black
Grey="\[\033[1;30m\]"       # Grey
Red="\[\033[0;31m\]"        # Red
lRed="\[\033[1;31m\]"       # Lite Red
Green="\[\033[0;32m\]"      # Green
lGreen="\[\033[1;32m\]"     # Lite Green
dGreen="\[\033[2;32m\]"     # Dark Green
Yellow="\[\033[0;33m\]"     # Yellow
Blue="\[\033[0;34m\]"       # Blue
lBlue="\[\033[1;34m\]"      # Lite Blue
Purple="\[\033[0;35m\]"     # Purple
Cyan="\[\033[0;36m\]"       # Cyan
lCyan="\[\033[1;36m\]"      # Lite Cyan
White="\[\033[0;37m\]"      # White
Brown="\[\033[1;33m\]"      # Brown

parse_git_branch() {
    tags=$(git describe --tag 2>/dev/null)
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1 @ ${tags})/"
}
parse_git_status() {
    #if_we_are_in_git_work_tree
    if $(git rev-parse --is-inside-work-tree &> /dev/null)
    then
        local ST=$(git status --short 2> /dev/null)
        #if changes exists, red - else green
        if [ -n "$ST" ]
        then
            PS1+=$Red
        else PS1+=$Green
        fi
    fi
}

build_prompt() {
    PS1="$Grey\t $(date +%m/%d/%y)$White $dGreen\u$White@$dGreen\h$White $Cyan\$(dirs)"
    parse_git_status
    PS1+="$(parse_git_branch)$White [\j]$ "
    #PS1+=" ($(parse_git_branch) @ $(git describe --tag 2>/dev/null))$White [\j]$ "
}
#stores function calls and executes prior to PS1 being set, allows you to cheat
#PROMPT_COMMAND=build_prompt
test_prompt() {
    PS1="[\t $(date +%m/%d/%y)] $Cyan\$(dirs)"
    parse_git_status
    PS1+="$(parse_git_branch)$White [\j]$ "
}
PROMPT_COMMAND=test_prompt
###################End zsh-like prompt settings ###################################

#golang 1.8 requires devtools-6
source /opt/rh/devtoolset-6/enable

#skip, cgo pointer to cgo pointer warnings for slice's
export GODEBUG=cgocheck=0
