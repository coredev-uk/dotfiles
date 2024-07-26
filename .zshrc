# Set the GPG_TTY to be the same as the TTY, either via the env var or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Environment variables
export PATH="$HOME/dotfiles/scripts:$HOME/.cargo/bin:$PATH"
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1 # For Steam Shader Stuff (https://github.com/ValveSoftware/steam-for-linux/issues/9748)

# Homebrew
if (command -v brew &> /dev/null); then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# First ensure zinit is installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" # Setting the directory we want to store zinit stuff

# Download zinit (if not already installed)
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.toml)"
fi

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History Vars
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias grep="grep --color=auto"
alias ls="ls --color --group-directories-first"
alias la="ls -la"
alias ..="cd .."
alias vim="nvim"
alias nvm="fnm"
alias jellyfin="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json jellyfinmediaplayer"

# Application Aliases
if (command -v code-insiders &> /dev/null); then
  alias code="code-insiders"
fi

if (command -v zeditor &> /dev/null); then
  alias zed="zeditor"
  alias z='zeditor'
fi

# Shell Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd)"
if [ Darwin = `uname` ]; then
  zstyle :omz:plugins:iterm2 shell-integration yes > /dev/null 2>&1

  if (command -v gls &> /dev/null); then
    alias ls="gls --color --group-directories-first"
  else
    echo "gls not found. Install coreutils to get gls"
  fi
fi

if (command -v pkgx &> /dev/null); then
  source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
fi
