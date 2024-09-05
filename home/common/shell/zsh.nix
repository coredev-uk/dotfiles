{ self, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        catppuccin.enable = true;
      };

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
        bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        export EDITOR=vim
      '';

      shellAliases = {
        # ls = "eza -gl --git --color=automatic";
        # tree = "eza --tree";
        # cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        open = "xdg-open";
        k = "kubectl";

        opget = "op item get \"$(op item list --format=json | jq -r '.[].title' | fzf)\"";

        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "nh clean all --keep-since 10d --keep 3";
        rln = "nh os switch ${self}";
        rlh = "nh home switch ${self}";
        rlb = "rln;rlh";
      };
    };
  };
}