#!/usr/bin/env bash
# Install/update dotfiles: copies configs into $HOME, backing up
# anything already there first. Safe to re-run to pick up updates
# (files are copied, not symlinked, so a `git pull` alone won't
# change your live configs until you re-run this script).
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y-%m-%d_%H-%M-%S)"
BACKED_UP=false

declare -A FILES=(
  [screenrc]=.screenrc
  [bashrc]=.bashrc
  [vimrc]=.vimrc
  [tmux.conf]=.tmux.conf
  [bash_profile]=.bash_profile
  [inputrc]=.inputrc
  [gitignore_global]=.gitignore_global
  [ackrc]=.ackrc
  [.gitconfig]=.gitconfig
)

backup_if_needed() {
  local target="$1" src="$2"
  if [ -e "$target" ] && cmp -s "$target" "$DOTFILES_DIR/$src"; then
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    BACKED_UP=true
    echo "Backing up $target -> $BACKUP_DIR/"
    mv "$target" "$BACKUP_DIR/"
  fi
}

copy() {
  local src="$1" dest="$HOME/$2"
  backup_if_needed "$dest" "$src"
  cp "$DOTFILES_DIR/$src" "$dest"
  echo "Copied $DOTFILES_DIR/$src -> $dest"
}

if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "Updating dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --ff-only || echo "Warning: git pull failed, continuing with local files"
fi

for src in "${!FILES[@]}"; do
  copy "$src" "${FILES[$src]}"
done

mkdir -p "$HOME/go/"{bin,src,pkg}
mkdir -p "$HOME/.vim/"{autoload,bundle,colors,doc,plugin}

for f in "$DOTFILES_DIR"/colors/*.vim; do
  name="colors/$(basename "$f")"
  target="$HOME/.vim/colors/$(basename "$f")"
  backup_if_needed "$target" "$name"
  cp "$f" "$target"
  echo "Copied $f -> $target"
done

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo
if $BACKED_UP; then
  echo "Existing configs backed up to: $BACKUP_DIR"
fi
echo "Done. Run: vim +PlugInstall +qall  to install vim plugins."
