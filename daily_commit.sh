#!/bin/bash

set -e

WIKI_DIR="$HOME/vimwiki"
TODAY=$(date +"%Y-%m-%d")

cd "$WIKI_DIR"
git add .
git commit -am "Auto commit of $(date +"%Y-%m-%d")"




#"https://dmoerner.wordpress.com/2017/08/14/vimwiki-and-git-autocommit/
#function Gitbranch()
#    return trim(system("git branch --show-current"))
#endfunction
#function Gitrebase()
#    return system('git rebase --onto '  Gitbranch()  ' master')
#endfunction
#function Gb()
#    return system("git rev-parse --abbrev-ref HEAD")
#endfunction
#
#command! Testgit call Testgit()
#function Testgit()
#        "let day = systemlist('date "+\%F"')[0]
#        let now = strftime("%F", localtime())
#        let l:current = system('git rev-parse --abbrev-ref HEAD')
#        let brebase = 'git rebase --onto ' . Gitbranch() . ' master'
#        let zbrebase = 'git rebase --onto ' . l:current . ' master'
#        "let current = Gb()
#        let current = Gitbranch()
#
#        "execute !printf('now - %s',now)
#        "execute !printf('day - %s',day)
#        "execute ":echo day - " day
#        "execute "echo now - " now
#        "echo "gitbranch - " Gitbranch()
#        ":read!date<cr>
#        "execute '!echo "day - "  'date +\%F'
#        "execute !echo 'now - ' now
#
#    "-----working-------
#        echo now
#        echo strftime("%F", localtime()  - 24*60*60)
#        echo Gitbranch()
#        echo l:current
#        echo system("date -d '2 day ago' +'%F'")
#        echo brebase
#        echo zbrebase
#        "au! BufWritePost ~/temp/git/* !git add "%";git commit -m "Auto commit of %:t."
#
#        "let rebase = ":!git rebase --onto "  current  " master"
#        "echo rebase
#        "
#        "for some reason, this returns the wrong results
#        "https://learnvimscriptthehardway.stevelosh.com/chapters/21.html
#        au! BufWritePost ~/temp/git/* !git add "%";git commit -m "Auto commit of %:t." "%"
#        if l:current != now
#            execute ':!git switch master'
#            "echo Gitrebase()
#            "execute $rebase
#            "call system("git rebase --onto "  current  " master")
#            execute ":!git merge --squash " . current  . " || echo git merge --squash failed"
#            execute ":!git commit -m 'Auto Squash of '" . current . " || echo git commit autosquash failed"
#            "execute ':!git rebase --onto ' . current .  ' master'
#            "execute ':!git rebase --onto ' . Gitbranch .  ' master'
#            "execute ':!git rebase --onto ' . l:current .  ' master'
#            "execute ':!git merge --squash ' . current
#            "execute ':!git commit -m 'Auto Squash of '' . current
#            execute ':!git checkout -b ' . now . ' || git checkout ' . now
#            "au! BufWritePost ~/temp/git/* !git add "%";git commit -m "Auto commit of %:t." "%"
#        "else
#            "au! BufWritePost ~/temp/git/* !git add "%";git commit -m "Auto commit of %:t." "%"
#        endif
#endfunction
#augroup testgit
#        au! BufWritePost ~/temp/git/* call Testgit()
#augroup END
#nnoremap <leader>k :Testgit<cr>
#
#function ZettleAutoSave()
#    let now = strftime("%F", localtime())
#
#    if Gitbranch() != now
#        execute ":!git switch master || echo master switch failed"
#        execute ":!git merge --squash " . current  . " || echo git merge --squash failed"
#        execute ":!git commit -m 'Auto Squash of '" . current . " || echo git commit autosquash failed"
#        execute ":!git checkout -b " . now . " || git checkout " . now
#        au! BufWritePost ~/vimwiki/* !git add "%";git commit -m "Auto commit of %:t."
#    else
#        au! BufWritePost ~/vimwiki/* !git add "%";git commit -m "Auto commit of %:t."
#    endif
#endfunction
#
#augroup vimwiki
#        "au! BufWritePost ~/vimwiki/* :call ZettleAutoSave()
#        "au! BufWritePost ~/vimwiki/**/* !git add "%";git commit -m "Auto commit of %:t."
#augroup END
