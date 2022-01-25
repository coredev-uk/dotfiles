# Setting custom environment vars
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -x PLATFORM (uname -s)
set -x GPG_TTY (tty)

# Fix the annoying terminal database message
if test "$PLATFORM" = "Darwin"
	set -x PATH "/usr/local/bin:/opt/homebrew/bin:$PATH"	
	set -x TERM "xterm-256color"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch

    # Gnome Keyring
    if test -n "$DESKTOP_SESSION"
      set -x (gnome-keyring-daemon --start | string split "=")
    end

		. ~/.config/fish/functions/rprompt.fish

    alias ls='exa -F --group-directories-first'
    alias idea='/home/paul/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/212.5457.46/bin/idea.sh'
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx >> .xsession-errors 2>&1
    end
end
