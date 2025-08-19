#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.config/!dotfiles"
LOCAL_BIN="$HOME/.local/bin"

# dry-run
DRY_RUN=false
if [[ "${1:-}" == "dry-run" ]]; then
  DRY_RUN=true
fi

link() {
  local src=$1
  local dest=$2

  if $DRY_RUN; then
    echo "Would link $dest -> $src"
    return
  fi

  # If dest exists and is not a symlink, back it up
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up $dest -> $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  # Create symlink
  ln -sfn "$src" "$dest"
  echo "Linked $dest -> $src"
}

# --- terminal ---
# ghostty | alacritty
# link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
# link "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

# --- zsh ---
# link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# --- nvim ---
# link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# --- tmux config ---
TMUX_DIR="$HOME/.config/tmux"
# mkdir -p $TMUX_DIR
# link "$DOTFILES_DIR/tmux/tmux.conf" "$TMUX_DIR/tmux.conf"
# link "$DOTFILES_DIR/tmux/.tmux-cht-command" "$TMUX_DIR/.tmux-cht-command"
# link "$DOTFILES_DIR/tmux/.tmux-cht-lang" "$TMUX_DIR/.tmux-cht-lang"
# mkdir -p "$HOME/.config/tmux-sessionizer"
# link "$DOTFILES_DIR/tmux/tmux-sessionizer.conf" "$HOME/.config/tmux-sessionizer/tmux-sessionizer.conf"

# --- tmux scripts ---
mkdir -p "$LOCAL_BIN"
for script in "$DOTFILES_DIR"/tmux/tmux-*; do
  [[ "$script" == *.conf ]] && continue

  if [[ -x "$script" || "$script" == *.sh ]]; then
    # chmod +x "$script"
    # link "$script" "$LOCAL_BIN/$(basename "$script")"
    :
  fi
done
