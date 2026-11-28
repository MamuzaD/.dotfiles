# env/PATH only, runs for every shell (scripts, popups, hooks)

typeset -U path

# xdg
export XDG_CONFIG_HOME="$HOME/.config"

# editor
export EDITOR=nvim

# homebrew
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
  [[ -z "${MANPATH-}" ]] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# rust
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)

# bob
[[ -d "$HOME/.local/share/bob/nvim-bin" ]] && path=("$HOME/.local/share/bob/nvim-bin" $path)

# go
[[ -d /usr/local/go/bin ]] && path=(/usr/local/go/bin $path)
[[ -d "$HOME/go/bin" ]] && path=("$HOME/go/bin" $path)

# bun
[[ -d "$HOME/.bun/bin" ]] && path=("$HOME/.bun/bin" $path)

# opencode
[[ -d "$HOME/.opencode/bin" ]] && path=("$HOME/.opencode/bin" $path)

case "$OSTYPE" in
  darwin*)
    # pnpm
    export PNPM_HOME="$HOME/Library/pnpm"
    [[ -d "$PNPM_HOME/bin" ]] && path=("$PNPM_HOME/bin" $path)

    # latex
    texlive_bin=(/usr/local/texlive/*/bin/universal-darwin(N/On[1]))
    (( $#texlive_bin )) && path=("$texlive_bin[1]" $path)
    unset texlive_bin

    # java
    if [[ -d /opt/homebrew/opt/openjdk@21 ]]; then
      export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
      path=("$JAVA_HOME/bin" $path)
    fi
    ;;
  linux*)
    # pnpm
    export PNPM_HOME="$HOME/.local/share/pnpm"
    [[ -d "$PNPM_HOME/bin" ]] && path=("$PNPM_HOME/bin" $path)
    ;;
esac

# fnm
[[ -d "$HOME/.local/share/fnm" ]] && path=("$HOME/.local/share/fnm" $path)
if [[ ! -o interactive && -d "$HOME/.local/share/fnm/aliases/default/bin" ]]; then
  path=("$HOME/.local/share/fnm/aliases/default/bin" $path)
fi

# local scripts
path=("$HOME/.local/bin" $path)

# sudoedit: full path, since sudo's secure_path skips ~/.local/share/bob
export SUDO_EDITOR="${commands[nvim]:-nvim}"

# wsl
if [[ -n "${WSL_DISTRO_NAME-}" ]]; then
  export COLORTERM=truecolor
  command -v win-zen >/dev/null 2>&1 && export BROWSER="win-zen"
fi

# privacy: opt out of telemetry (DO_NOT_TRACK is honored by many CLIs)
export DO_NOT_TRACK=1
export T3CODE_TELEMETRY_ENABLED=false

# local
[[ -f "$HOME/dotfiles/zsh/.zshenv.local" ]] && source "$HOME/dotfiles/zsh/.zshenv.local"
