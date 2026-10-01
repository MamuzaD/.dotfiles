# env/PATH only, runs for every shell (scripts, popups, hooks)

typeset -U path

# xdg
export XDG_CONFIG_HOME="$HOME/.config"

# for local scripts
export PATH="$HOME/.local/bin:$PATH"

# rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# bob (nvim)
[[ -f "$HOME/.local/share/bob/env/env.sh" ]] && . "$HOME/.local/share/bob/env/env.sh"

# fnm (brew on mac, ~/.local/share/fnm on linux)
[[ -d /opt/homebrew/bin ]] && export PATH="/opt/homebrew/bin:$PATH"
[[ -d "$HOME/.local/share/fnm" ]] && export PATH="$HOME/.local/share/fnm:$PATH"
# non-interactive only, .zshrc handles interactive
if [[ ! -o interactive ]] && command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --shell zsh)"
fi
