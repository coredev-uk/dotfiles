# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Path Updated
export PATH="/usr/local/bin:/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Cargo Stupidity
export CARGO_NET_GIT_FETCH_WITH_CLI=true

if [ Darwin = `uname` ]; then
  # Homebrew Path Changes
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

if [ Linux = `uname` ]; then
  # For Steam Shader Stuff (https://github.com/ValveSoftware/steam-for-linux/issues/9748)
  export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
fi

# SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit

## Zinit Plugins
zinit light ohmyzsh/ohmyzsh
zinit ice depth"1"; zinit light romkatv/powerlevel10k
zinit snippet OMZP::git
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

if [ Darwin = `uname` ]; then
  zinit snippet OMZP::brew
  zinit snippet OMZP::iterm2
  zstyle :omz:plugins:iterm2 shell-integration yes > /dev/null 2>&1
fi

### More
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

setopt auto_cd

export LD_LIBRARY_PATH=/usr/local/lib

# Aliases
alias vi=nvim
alias vim=nvim
alias ls='eza -F --group-directories-first'
alias yarn='corepack yarn' # Use corepack for yarn
alias nvm='fnm' # Use fnm for nvm

# P10k customizations
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Fix for password store
export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'

bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export MOZ_ENABLE_WAYLAND=1
fi

zle_highlight=('paste:none')

# FNM
if [[ (Linux = `uname` && ! -f "$HOME/.local/share/fnm/fnm") || (Darwin = `uname` && ! -f "/opt/homebrew/bin/fnm") ]]; then
  curl -fsSL https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
else
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

if (command -v zoxide > /dev/null); then
  eval "$(zoxide init --cmd cd zsh)"
fi

if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi
