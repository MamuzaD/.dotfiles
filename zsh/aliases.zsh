
alias ls='eza -1a --icons --git --group-directories-first'
alias lsg='eza -ga --icons --git --group-directories-first'
alias vim='nvim'
alias v='nvim'
alias ts="tmux-sessionizer"

# lazygit (cd to last repo on quit)
lg() {
  local dir_file="$(mktemp -u)"
  LAZYGIT_NEW_DIR_FILE="$dir_file" lazygit "$@"
  if [[ -f "$dir_file" ]]; then
    local new_dir="$(<"$dir_file")"
    rm -f "$dir_file"
    [[ -d "$new_dir" ]] && cd "$new_dir"
  fi
}
