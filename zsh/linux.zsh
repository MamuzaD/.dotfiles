# linux-only config, sourced from .zshrc

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# go
[[ -d /usr/local/go/bin ]] && export PATH="$PATH:/usr/local/go/bin"

# bun
[[ -d "$HOME/.bun/bin" ]] && export PATH="$HOME/.bun/bin:$PATH"

# wsl
if [[ -n "${WSL_DISTRO_NAME-}" ]]; then
  export COLORTERM=truecolor
  # hand URLs off to the Windows browser instead of w3m
  command -v win-zen >/dev/null 2>&1 && export BROWSER="win-zen"
fi
