# .bashrc
# echo $STY
# echo $TMUX
# history -w        write the current history to the history file
# reset terminal, scrolling history
# tput rmcup
#
#set -e


test -d ~/bash_history/ || mkdir ~/bash_history/

# SSH Agent — reuse existing or start one (no orphans)
_ssh_agent_env=~/.ssh/agent.env
if [ -f "$_ssh_agent_env" ]; then
  . "$_ssh_agent_env" >/dev/null
fi
if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
  eval "$(ssh-agent)" >/dev/null
  echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$_ssh_agent_env"
  echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$_ssh_agent_env"
fi
unset _ssh_agent_env

# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    alias ls='ls --color=auto'
    # FZF (if available)
    [ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
    [ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    command -v pyenv &>/dev/null && eval "$(pyenv init - bash)"
    # gvm
    [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
    # rvm
    export PATH="$PATH:$HOME/.rvm/bin"
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

# https://gitlab.com/GasparVardanyan/dotfiles/-/blob/master/dotfiles/zsh/.zshrc
#Busy, a joke to friends
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
alias chess="telnet freechess.org"
alias gbs='git-branch-status'
alias wtr="curl wttr.in/"

export TASKDDATA=/var/lib/taskd
export EDITOR=vim
alias in="task add +inbox"
alias calc="task calc"                              #taskwarrior ver 2.4.0
alias tac="task active"
alias td="task due"
alias taw="task waiting"
alias tun="task unblocked"
alias tbk="task blocked"
alias tls="task list"
alias tnt="task next"
alias trd="task ready"
alias th="task next +home limit:20"
alias tw="task next +work limit:20"


# SICP Racket path
export PATH=$PATH:/Applications/Racket\ v7.3/bin/:/usr/sbin:/usr/share/bcc/tools/

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
#https://www.soberkoder.com/unlimited-bash-history/
HISTFILE=~/bash_history/$(date +%Y-%m)
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -lath'
#HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'         #dunno
export HISTIGNORE

#golang 1.8 requires devtools-6
if [ -f /opt/rh/devtoolset-6/enable ]; then
    source /opt/rh/devtoolset-6/enable
fi

#skip, cgo pointer to cgo pointer warnings for slice's
export GODEBUG=cgocheck=0

# add go to path
export PATH=$PATH:/home/chris/go/bin:/usr/local/go/bin:/usr/local/bin/

# couldnt find working directory gopls vimgo
#let g:go_null_module_warning = 0
#let g:go_debug=['shell-commands']

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

# auto cd to dir name
# shopt -s autocd
################FUNCTIONS##########################

#https://oscarnajera.com/2020/10/fun-with-rofi-and-guile-a-minimal-habit-tracker/
habitlog() {
    echo $(date +%s),${2:-1} >> "$HOME/habits/${1:-myhabit}.csv"
}

#alias f="find . \"*$1*\""
# fuzzy find filenames
function f() {
    find . -iname "*$1*"
}

#https://github.com/kaihendry/dotfiles/blob/master/.bashrc
#https://www.soberkoder.com/unlimited-bash-history/
h() {
    grep -irn --color $@ ~/bash_history/*
    #ack $@ ~/bash_history/*
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
function usage() {
  echo "Usage: $0 <name> [options]"
}
#https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
################pomo###################
function countdown(){
  # Error handling omitted (for now)
  if [[ "$#" -ne 1 ]]; then
          usage
          return 1
  elif  [[ "$1" == -h ]]; then
    usage
    return 0
  else
           date1=$((`date +%s` + $1));
           while [ "$date1" -ge `date +%s` ]; do
                 echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
                 sleep 0.1
           done
  fi
}
function stopwatch(){
  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
}

################sysadmin like aliases###################
alias godocweb='godoc -http=:6060' # Spawns a godoc web server
alias ports='sudo lsof -i -P -n | sort -f '   # Displays all processes that are serving or listening on ports, sorted alphabetically
alias resetmouse='printf '"'"'\e[?1000l'"'" #disable-mouse-reporting-in-a-terminal-session-after-tmux-exits-unexpectedly
alias ducks='du -cks * |sort -rn |head -11'
alias ducks2='du -cks -- * | sort -rn | head'
alias tulip='netstat -tulpn'
#alias tree="ls -ld $PWD/**"
#alias tree="ls -ld `pwd`/**"
#alias ls="ls -G"
alias ld="ls -ld ./**"
#https://unix.stackexchange.com/questions/122597/sort-the-files-in-the-directory-recursively-based-on-last-modified-date
#alias tree="ls -dltr **/*"
alias vtree="tree -I vendor -fNpugshFviC"
alias ntoe="note"
alias dmesg="dmesg -T"


#set for macbook
# added case above
alias ll="ls -lathr"                     # long, all, human readable, sort by time
alias lr="ls -lRath"                    # long, all, human readable, sort by time, recursive
alias lss="ls -laSh"                    # long, all, human readable, sort by size
alias cp="cp -vi"                       # -v verbose -i request confirmation before overwrite
alias mv="mv -v"
alias rm="rm -vi"
alias rmf="rm -v"
alias mkdir='mkdir -pv'                  # -p creates parent directories as needed, -v ouputs to console when it does
alias grep='grep --color'                  # always color
alias diff='diff --color'
#alias grep='ack'                  # always color
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias ..3='cd ../../../'                     # Go back 3 directory levels
alias ..4='cd ../../../../'                  # Go back 4 directory levels
alias ..5='cd ../../../../../'               # Go back 5 directory levels
alias ..6='cd ../../../../../../'            # Go back 6 directory levels
alias hs="history | grep"
alias lb="ls -lath ~/.vim/bundle/"
alias vi="vim ~/vimwiki/index.md"
alias vd="vim ~/vimwiki/zettel/diary/diary.md"
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"
alias vs="vim ~/.ssh/config"


####################### git aliases ###################
alias gun='~/dotfiles/git-untracked.sh'
alias grin="grep -rn --ignore-case --color --exclude-dir={.git,.svn,honnef.co,golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor} --exclude=.session.vim"
alias ggrep="grep --exclude-dir={golang.org,github.com,code.google.com,gopkg.in,9fans.net,.vendor,vendor}"
alias gsc="sub-status"
alias gs="git status"
alias gd='git diff --stat -w'      # Shows file changes
alias gb='git branch'
alias gda="git diff"
alias gac="git commit -am "
alias glo='git log --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit --color |head -20'     #git log old
alias gl='git log -n20 --graph --pretty=format:"%C(bold blue)%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit --color'  #git log head
#alias gl='git log --graph --pretty=format:"%C(bold blue)%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit --color |head -20'  #git log head
alias gln='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'        #git log new
alias glf='git log  --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'        #git log new no graph
alias glc='git log  --abbrev-commit --pretty=format:"%C(bold blue)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) reset"'      #git log compare format
alias glh='git log  --all --abbrev-commit --pretty=format:"%C(bold blue)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) reset"'      #git log all compare format
alias glv='git log  --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit' #git log verbose
alias gla='git log --all --graph --pretty=format:"%Cred%H%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit' #git log all
alias gls="git log  --pretty='format:%H %Cred%d %C(yellow)%ad%Creset %ae %Cgreen%s%Creset' --graph" #git log short
alias gli="git log --format='%C(yellow)%h %C(blue)%as%C(auto)%d%Creset %s %C(dim)[%an, %ar]' --graph --topo-order" #ianthehenry
alias gco='git checkout'           # Checkout a branch or file
alias main='git checkout master'           # Checkout master branch
alias gbv='git branch -vvr'           # Checkout master branch
#the next 2x are similar to this view - git log --graph --abbrev-commit --pretty=oneline release/1.1..master
alias gcomp="diff -y <(git log --oneline master) <(git log --oneline ) |head -20"
alias gcompa="diff -y <(git log --oneline master) <(git log --oneline )"
gcompb() {
    #echo "$1"
    diff -y <(git log --oneline ) <(git log --oneline $1)
}
# kiro implemented funcitons
gcompr() {
    local branch1="${1:-master}"
    local branch2="${2:-$(git branch --show-current)}"
    diff -y <(git log --oneline "$branch1") <(git log --oneline "$branch2") | head -${3:-20}
}
alias gbh="git for-each-ref --sort='-committerdate:iso8601' --format='%(committerdate:relative)|%(refname:short)|%(committername)' refs/remotes/ refs/heads/| column -s '|' -t"

#  Usage:
#  gdiffbranch master feature-branch
#  gdiffbranch  # uses defaults
#  gdiffbranch master feature-branch | less -R  # pager with color
#  Add | less -R at the end or wrap it with a pause between files if you want to step through them:

gdiffb() {
	local branch1="${1:-master}"
	local branch2="${2:-$(git branch --show-current)}"
	for file in $(git diff "$branch1" "$branch2" --name-only); do
	  echo "=== $file ==="
	  diff -y <(git show "$branch1:$file" 2>/dev/null) <(git show "$branch2:$file" 2>/dev/null) | colordiff
	  echo ""
	done
}

gdv() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: gdiffbranch [branch1] [branch2]"
      echo "  branch1: base branch (default: master)"
      echo "  branch2: compare branch (default: current branch)"
      echo "  Diffs each changed file side-by-side between the two branches."
      return
    fi
    local branch1="${1:-master}"
    local branch2="${2:-$(git branch --show-current)}"
    for file in $(git diff "$branch1" "$branch2" --name-only); do
      local in_b1 in_b2
      in_b1=$(git show "$branch1:$file" 2>/dev/null)
      in_b2=$(git show "$branch2:$file" 2>/dev/null)
  
      if [[ -z "$in_b1" && -n "$in_b2" ]]; then
        echo "=== $file [NEW in $branch2] ==="
        diff -y <(echo "") <(echo "$in_b2") | colordiff
      elif [[ -n "$in_b1" && -z "$in_b2" ]]; then
        echo "=== $file [DELETED in $branch2] ==="
        diff -y <(echo "$in_b1") <(echo "") | colordiff
      else
        echo "=== $file ==="
        diff -y <(echo "$in_b1") <(echo "$in_b2") | colordiff
      fi
  
      echo ""
      read -p "Next file? (q to quit) " ans
      [[ "$ans" == "q" ]] && break
    done
}

gdiffbranch() {
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: gdiffbranch [branch1] [branch2]"
  echo "  branch1: base branch (default: master)"
  echo "  branch2: compare branch (default: current branch)"
  echo "  Diffs each changed file side-by-side between the two branches."
  return
fi
local branch1="${1:-master}"
local branch2="${2:-$(git branch --show-current)}"
(
  for file in $(git diff "$branch1" "$branch2" --name-only); do
	local in_b1 in_b2
	in_b1=$(git show "$branch1:$file" 2>/dev/null || true)
	in_b2=$(git show "$branch2:$file" 2>/dev/null || true)

	if [[ -z "$in_b1" && -n "$in_b2" ]]; then
	  echo "=== $file [NEW in $branch2] ==="
	  diff -y <(echo "") <(echo "$in_b2") | colordiff || true
	elif [[ -n "$in_b1" && -z "$in_b2" ]]; then
	  echo "=== $file [DELETED in $branch2] ==="
	  diff -y <(echo "$in_b1") <(echo "") | colordiff || true
	else
	  echo "=== $file ==="
	  diff -y <(echo "$in_b1") <(echo "$in_b2") | colordiff || true
	fi
	echo ""
  done
) | less -R
}





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
    #PS1="[\h \t $(date +%m/%d/%y)] $Cyan\W "
    PS1="[\h \t $(date +%m/%d/%y)] $Cyan\$(dirs)"
    parse_git_status
    PS1+="$(parse_git_branch)$White [\j]$ "
}
PROMPT_COMMAND=test_prompt
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
###################End zsh-like prompt settings ###################################

alias mtr=/opt/homebrew/share/man/man8/mtr.8


export NVM_DIR="$HOME/.nvm"
# Lazy-load NVM (saves ~4s on shell startup)
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm use default &>/dev/null; command node "$@"; }
npm() { nvm use default &>/dev/null; command npm "$@"; }
npx() { nvm use default &>/dev/null; command npx "$@"; }
export PATH="$HOME/.local/bin:$PATH"
# source ~/.bash_profile  # REMOVED: causes circular sourcing hang

# Source work-specific overrides if present
if [ -f ~/.bashrc_work ]; then
    source ~/.bashrc_work
fi

# Cargo/Rust
