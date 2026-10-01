# macOS-only config, sourced from .zshrc

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# latex (newest texlive)
texlive_bin=(/usr/local/texlive/*/bin/universal-darwin(N/On[1]))
(( $#texlive_bin )) && export PATH="$texlive_bin[1]:$PATH"
unset texlive_bin

# postgres
[[ -d /opt/homebrew/opt/postgresql@18/bin ]] && export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# java
if [[ -d /opt/homebrew/opt/openjdk@21 ]]; then
  export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# android
if [[ -d "$HOME/Library/Android/sdk" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
fi

# openers
alias chrome='open -a "Google Chrome"'
