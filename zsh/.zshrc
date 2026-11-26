# powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ohmyzsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions aliases)
fpath+=~/.zfunc
source $ZSH/oh-my-zsh.sh

# daniel's aliases
source "$HOME/dotfiles/zsh/aliases.zsh"

# fnm
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# bun completions (PATH is in .zshenv)
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# local
[[ -f "$HOME/dotfiles/zsh/.zshrc.local" ]] && source "$HOME/dotfiles/zsh/.zshrc.local"
