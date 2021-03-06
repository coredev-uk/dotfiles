# Setting custom environment vars
set -x PLATFORM (uname -s)
set -x GPG_TTY (tty)
set -x STARSHIP_CONFIG "$HOME/.config/starship.toml"
set fish_greeting

# Fix the annoying terminal database message
if test "$PLATFORM" = "Darwin"
	set -x PATH "/usr/local/bin:/opt/homebrew/bin:$PATH"	
	set -x TERM "xterm-256color"
end


if status is-interactive
    # Commands to run in interactive sessions can go here
    #neofetch
    if test "$PLATFORM" = "Linux"
	keychain --quiet --agents ssh
    end

    # SSH Agent
    if test -z (pgrep ssh-agent | string collect)
        eval (ssh-agent -c)
        #set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end

    # Gnome Keyring
    if test -n "$DESKTOP_SESSION"
      set -x (gnome-keyring-daemon --start | string split "=")
    end

	. ~/.config/fish/functions/rprompt.fish

    alias ls='exa -F --group-directories-first'
	alias vim='nvim'
	alias vi='nvim'
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx >> .xsession-errors 2>&1
    end
end

starship init fish | source

# Bun
set -Ux BUN_INSTALL "$HOME/.bun"
set -px --path PATH "$HOME/.bun/bin"

