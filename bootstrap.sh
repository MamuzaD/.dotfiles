#!/usr/bin/env bash
set -euo pipefail

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DOTFILES_DIR="$XDG_CONFIG_HOME/dotfiles"
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
  mkdir -p "$(dirname "$dest")"

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
# link "$DOTFILES_DIR/ghostty/config" "$XDG_CONFIG_HOME/ghostty/config"
# link "$DOTFILES_DIR/alacritty" "$XDG_CONFIG_HOME/alacritty"

# --- zsh ---
# link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# --- nvim ---
# link "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"

# --- tmux config ---
# link "$DOTFILES_DIR/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
# link "$DOTFILES_DIR/tmux/.tmux-cht-command" "$XDG_CONFIG_HOME/tmux/.tmux-cht-command"
# link "$DOTFILES_DIR/tmux/.tmux-cht-lang" "$XDG_CONFIG_HOME/tmux/.tmux-cht-lang"
# link "$DOTFILES_DIR/tmux/tmux-sessionizer.conf" "$XDG_CONFIG_HOME/tmux/tmux-sessionizer.conf"

# lazygit
# link "$DOTFILES_DIR/lazygit/config.yml" "$XDG_CONFIG_HOME/lazygit/config.yml"

# --- tmux scripts ---
for script in "$DOTFILES_DIR"/tmux/tmux-*; do
  [[ "$script" == *.conf ]] && continue

  if [[ -x "$script" || "$script" == *.sh ]]; then
    # chmod +x "$script"
    # link "$script" "$LOCAL_BIN/$(basename "$script")"
    :
  fi
done

# --- general scripts ---
for script in "$DOTFILES_DIR"/scripts/*; do
  if [[ -x "$script" || "$script" == *.sh ]]; then
    # link "$script" "$LOCAL_BIN/$(basename "$script")"
    # chmod +x "$script"
    :
  fi
done
