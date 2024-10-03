eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.cargo/env"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# poetry
export PATH="$HOME/.local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kaiyang/Downloads/Installers/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kaiyang/Downloads/Installers/google-cloud-sdk/path.zsh.inc'; fi

# julia
export PATH="$HOME/.juliaup/bin:$PATH"
