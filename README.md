# dotfiles

## Setup

Run the install script (safe to re-run any time to pick up updates):

```
git clone <this repo> ~/dotfiles
~/dotfiles/install.sh
```

It will:
- `git pull` the repo first (if it's a git checkout)
- copy (not symlink) `screenrc`, `bashrc`, `vimrc`, `tmux.conf`, `bash_profile`,
  `inputrc`, `gitignore_global`, `ackrc`, `.gitconfig`, and the vim colorschemes
  into `$HOME` — files are copied on purpose, so a stray `git pull` in this repo
  can never silently change your live configs
- back up anything that already exists at those paths (and differs from the
  repo's copy) into `~/.dotfiles_backup/<YYYY-MM-DD_HH-MM-SS>/` first
- create `$HOME/go/{bin,src,pkg}` and `$HOME/.vim/{autoload,bundle,colors,doc,plugin}`
- fetch `vim-plug` if it isn't already installed

Since configs are copied, re-run `install.sh` any time you want to pick up
changes made in the repo — it won't happen automatically.

Then inside vim run `:PlugInstall`.

## What's in here

- `bashrc`, `bash_profile`, `inputrc`, `vimrc`, `tmux.conf`, `screenrc`,
  `ackrc`, `gitignore_global`, `.gitconfig` — the configs `install.sh` deploys
- `colors/` — vim colorschemes, deployed to `~/.vim/colors`
- `git-info.sh` — print remote/branch/config info for the current git repo
- `git-untracked.sh` — diff untracked files against `/dev/null` (aliased as `gun`)
- `timesheet.sh` — generate a weekly Taskwarrior timesheet report
- `daily_commit.sh` — auto-commit `~/vimwiki` for the day

## Docs

- [vim git diff workflow](docs/vim-git-diff-workflow.md)

<!-- branch protection test, safe to remove -->
