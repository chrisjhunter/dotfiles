# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Fixing agent forwarding with screen
# https://gist.github.com/martijnvermaat/8070533
# https://developer.github.com/v3/guides/using-ssh-agent-forwarding/
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    alias ls='ls --color=auto'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    alias ls='ls -G'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# SICP Racket path
export PATH=$PATH:/Applications/Racket\ v7.3/bin/

# MAC terminal colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

#helps screen inherit, works on modern terms
export TERM=xterm-256color
#export TERM=screen-256color

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '
export HISTSIZE=10000                              # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
export HISTCONTROL=ignoreboth                      # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -lath'
#HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'         #dunno
export HISTIGNORE

#golang 1.8 requires devtools-6
source /opt/rh/devtoolset-6/enable

#skip, cgo pointer to cgo pointer warnings for slice's
export GODEBUG=cgocheck=0

#ssh-add -K <path_to_private_key>
# or put in .bash_profile, to keep private

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# bash cli behaves like vi
#set -o vi

    #set -x     Print command traces before executing command.
    #set -o
    #set -v     Prints shell input lines as they are read.
    #http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_03.html
    #https://www.gnu.org/software/bash/manual/bashref.html#The-Set-Builtin

# ignore case tab completion
bind 'set completion-ignore-case on'

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

################FUNCTIONS##########################

#alias f="find . \"*$1*\""
# fuzzy find filenames
function f() {
    find . -iname "*$1*"
}

# open all golang files in subdirectories
function ago() {
    #find . -maxdepth 2 -iname "*.go" -exec vi {} \; 2>/dev/null
    vim $(find . -not \( -path ./vendor -prune \) -iname "*.go")
    #vim $(find . -maxdepth 3 -iname "*.go")
    #vim `find . -maxdepth 2 -iname "*.go"`

}

# use extract instead of tar/rar/gunzip
function extract () {
  if [ -f $1 ] ; then
    case $1 in
          *.tar.bz2)     tar xvjf $1    ;;
          *.tar.gz)      tar xvzf $1    ;;
          *.bz2)         bunzip2 $1     ;;
          *.rar)         rar x $1       ;;
          *.gz)          gunzip $1      ;;
          *.tar)         tar xvf $1     ;;
          *.tbz2)        tar xvjf $1    ;;
          *.zip)         unzip $1       ;;
          *.Z)           uncompress $1  ;;
          *.7z)          7z x $1        ;;
          *)             echo "don't know how to extract '%1'…"
      esac
    else
      echo "'$1' is not a valid file!"
    fi
}

# create daily scratch notes
function note ()
{
  dyna_year=$(date +%Y);
  dyna_month=$(date +%m);
  dyna_day=$(date +%d);
  dyna_dir=~/Documents/Notes/$dyna_year/$dyna_month;
  dyna_file=$dyna_day.md;
  if [ ! -d $dyna_dir ]; then
      mkdir -p $dyna_dir;
      #find ~/logs/ -type d -mtime +15 -exec rm -rf {} \;
      find ~/Documents/Notes/$dyna_year -type f ! -name "*.gz" -mtime +1 -exec gzip -9q {} \;
  fi
  vim $dyna_dir/$dyna_file;
}

#auto logging telnet
function tel ()
{
  my_date=$(date -u +%Y-%m-%d);
  my_time=$(date +%H.%M.%S);
  my_dir=~/logs/$my_date;
  my_file=$1.$my_time.log;
  if [ ! -d $my_dir ]; then
      mkdir -p ~/logs/$my_date;
      #find ~/logs/ -type d -mtime +15 -exec rm -rf {} \;
      find ~/logs/ -type f ! -name "*.gz" -mtime +1 -exec gzip -9q {} \;
  fi
  telnet $1 | tee $my_dir/$my_file;
}

#auto logging ssh
function s ()
{
  my_date=$(date -u +%Y-%m-%d);
  my_time=$(date +%H.%M.%S);
  my_dir=~/logs/$my_date;
  my_file=$1.$my_time.log;
  if [ ! -d $my_dir ]; then
      mkdir -p ~/logs/$my_date;
      #find ~/logs/ -type d -mtime +15 -exec rm -rf {} \;
      find ~/logs/ -type f ! -name "*.gz" -mtime +1 -exec gzip -9q {} \;
  fi
  ssh $1 | tee $my_dir/$my_file;
}

#git push, create feature branch if doesn't exists
function gp() {
    BRANCH=$(git symbolic-ref --short HEAD)
    REMOTE=$(git status -sb | grep '...origin')
    if [ -z "$REMOTE" ]
    then
        git push --set-upstream origin $BRANCH
    else
        git push
    fi
}

#find filename, then grep for regex
function gofind() {
    grep $2 $(find . -type f -name \*$1)
}


################sysadmin like aliases###################
alias godocweb='godoc -http=:6060' # Spawns a godoc web server
alias ports='sudo lsof -i -P -n | sort -f '   # Displays all processes that are serving or listening on ports, sorted alphabetically
alias resetmouse='printf '"'"'\e[?1000l'"'" #disable-mouse-reporting-in-a-terminal-session-after-tmux-exits-unexpectedly
alias ducks='du -cks * |sort -rn |head -11'
alias tulip='netstat -tulpn'
alias tree="tree -I vendor"
#set for macbook
# added case above
#alias ls="ls -G"
alias ll="ls -lath"                     # long, all, human readable, sort by time
alias lr="ls -lRath"                    # long, all, human readable, sort by time, recursive
alias lss="ls -laSh"                    # long, all, human readable, sort by size
alias cp="cp -vi"                       # -v verbose -i request confirmation before overwrite
alias mv="mv -v"
alias rm="rm -vi"
alias rmf="rm -v"
alias mkdir='mkdir -pv'                  # -p creates parent directories as needed, -v ouputs to console when it does
alias grep='grep --color'                  # always color
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias ..3='cd ../../../'                     # Go back 3 directory levels
alias ..4='cd ../../../../'                  # Go back 4 directory levels
alias ..5='cd ../../../../../'               # Go back 5 directory levels
alias ..6='cd ../../../../../../'            # Go back 6 directory levels
alias hs="history | grep"
alias lb="ls -lath ~/.vim/bundle/"
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"
alias vs="vim ~/.ssh/config"


####################### git aliases ###################
alias grin="grep -rn --ignore-case --color --exclude-dir={.git,.svn,honnef.co,golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor} --exclude=.session.vim"
alias ggrep="grep --exclude-dir={golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor}"
alias gsc="sub-status"
alias gs="git status"
alias gd='git diff --stat -w'      # Shows file changes
alias gb='git branch'
alias gda="git diff"
alias gac="git commit -am "
alias glo='git log --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit --color |head -20'     #git log old
alias gl='git log --graph --pretty=format:"%C(bold blue)%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit --color |head -20'  #git log head
alias gln='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'        #git log new
alias glf='git log  --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'        #git log new no graph
alias glc='git log  --abbrev-commit --pretty=format:"%C(bold blue)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) reset"'      #git log compare format
alias glh='git log  --all --abbrev-commit --pretty=format:"%C(bold blue)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) reset"'      #git log all compare format
alias glv='git log  --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit' #git log verbose
alias gla='git log --all --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit' #git log all
alias gls="git log  --pretty='format:%H %Cred%d %C(yellow)%ad%Creset %ae %Cgreen%s%Creset' --graph" #git log short
alias gco='git checkout'           # Checkout a branch or file
alias mast='git checkout master'           # Checkout master branch
alias gbv='git branch -vvr'           # Checkout master branch
#the next 2x are similar to this view - git log --graph --abbrev-commit --pretty=oneline release/1.1..master
alias gcomp="diff -y <(git log --oneline ) <(git log --oneline master) |head -20"
alias gcompa="diff -y <(git log --oneline ) <(git log --oneline master)"


#####################ZSH like PS1 below#####################

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

function parse_git_branch() {
    tags=$(git describe --tag 2>/dev/null)
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1 @ ${tags})/"
}
function orig_parse_git_status() {
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
function parse_git_status() {
    #if_we_are_in_git_work_tree
    if $(git rev-parse --is-inside-work-tree &> /dev/null)
    then
        local ST=$(git status --short 2> /dev/null)
        #local UN=$(git status | grep "not staged|Untracked")
        local UN=$(git status | grep "not staged")
        #if changes exists, red - else green
        if [ -n "$UN" ]
        then
                PS1+=$Red
        elif [ -n "$ST" ]
        then
                PS1+=$Yellow
        else
                PS1+=$Green
        fi
        #PS1+=$(parse_git_branch)
    fi
}

#Linux posix normal build
function build_prompt() {
    #PS1="$Grey\t $(date +%m/%d/%y)$White $dGreen\u$White@$dGreen\h$White $Cyan\$(dirs)"
    PS1="[$(date +"%H:%M:%S %m/%e/%G")] $Cyan\W"
    parse_git_status
    PS1+="$(parse_git_branch)$White [\j]$ "
    #PS1+=" ($(parse_git_branch) @ $(git describe --tag 2>/dev/null))$White [\j]$ "
}
#stores function calls and executes prior to PS1 being set, allows you to cheat
#PROMPT_COMMAND=build_prompt

#MACOS prompt
function test_prompt() {
    #PS1="\t \D{%D} $Cyan\$(dirs)"
    PS1="[\h \t $(date +%m/%d/%y)] $Cyan\$(dirs)"
    parse_git_status
    PS1+="$(parse_git_branch)$White [\j]$ "
}
PROMPT_COMMAND=test_prompt
###################End zsh-like prompt settings ###################################

[[ -s "/home/chunter/.gvm/scripts/gvm" ]] && source "/home/chunter/.gvm/scripts/gvm"
