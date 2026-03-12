#!/usr/bin/env bash
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# just to simplify fzf styling
fzf_default_opts=(
  --bind "ctrl-j:down,ctrl-k:up"
  --color "prompt:#7AA2f7,spinner:#7AA2f7,header:#7AA2f7,pointer:#7AA2f7,preview-bg:#1b2538"
  --info=hidden
  --border=rounded
  --border-label=cht.sh
  --border-label-pos=0
  --padding=1
  --reverse
  --cycle
  --prompt="> "
  --bind=tab:accept
)

selected=$(
  cat $CONFIG_HOME/tmux/.tmux-cht-lang $CONFIG_HOME/tmux/.tmux-cht-command | fzf \
    "${fzf_default_opts[@]}" \
    --header="Select a language or command"
)
if [[ -z $selected ]]; then
  exit 0
fi

query=$(
  fzf \
    "${fzf_default_opts[@]}" \
    --print-query \
    --prompt="query > " \
    --border-label="cht.sh query" \
    --height=10% </dev/null
)

if grep -qs "$selected" $CONFIG_HOME/tmux/.tmux-cht-lang; then
  query=$(echo $query | tr ' ' '+')

  printf "%s\n" "cht.sh/$selected/$query"

  tmux neww zsh -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
  tmux neww zsh -c "curl -s cht.sh/$selected~$query | less"
fi
