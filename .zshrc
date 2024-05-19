# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the GPG_TTY to be the same as the TTY, either via the env var or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Environment variables
export PATH="/usr/local/bin:/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
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

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

# Load completions 
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run 'p10k configure' or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
alias ls="eza --color --group-directories-first"
alias la="ls -la"
alias ..="cd .."
alias vim="nvim"
alias nvm="fnm"

# Shell Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env)"
if [ Darwin = `uname` ]; then
  zstyle :omz:plugins:iterm2 shell-integration yes > /dev/null 2>&1
fi
 
if (command -v pkgx &> /dev/null); then
  source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
fi
