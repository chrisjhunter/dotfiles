# dotfiles

cobbled together with snippets from: statico, samwho, cjhveal, junegunn,
george ornbo, tpope, snow-dev, devinrm/thottbot, trishume, skwp,
stephpy, connermcd, coolaj86, doug black, victor engmark, amix vim,
mcantor, jfrazelle, nicknisi, damian-conway, benjamin g, stevelosh,
witzel3, sam rowe, kring ag, jose de la o, devaudio, sclark, pfalso,
sleuth, random hackernews and tnowalk


## vim git diff workflow
vim $(git diff <hash> --name-only)
:Gvdiff <hash>

## How to setup configs

ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/inputrc ~/.inputrc
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

source ~/.bashrc

:PlugInstall
