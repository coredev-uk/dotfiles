{
  pkgs,
  meta,
  ...
}:
{
  home.packages = with pkgs; [
    zsh-syntax-highlighting
  ];

  catppuccin.zsh-syntax-highlighting.enable = true;

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "the-unnamed";
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };

      initContent = ''
        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

        eval "$(direnv hook zsh)" # direnv auto shell activation hook
        TERM=xterm-256color

        export GIO_MODULE_DIR=${pkgs.glib-networking}/lib/gio/modules/ # Patch for webkit2gtk ssl error (https://github.com/tauri-apps/wry/issues/605#issuecomment-1215756032)
      '';

      sessionVariables = {
        EDITOR = "nvim";
        NH_FLAKE = meta.flakePath;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "zoxide"
          "sudo"
          "ssh"
          "ssh-agent"
          "npm"
          "git"
          "aliases"
          "colored-man-pages"
          "docker"
        ];
      };

      plugins = [ ];

      shellAliases = {
        la = "ls -la";
        ".." = "cd ..";
        ls = "eza -gl --git --group-directories-first --color=automatic";
        tree = "eza --tree";
        cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        nix-update = "nh clean all; nh os switch --update ${meta.flakePath}; nh home switch ${meta.flakePath}";
        darwin-update = "nh clean all; nh darwin switch --update ${meta.flakePath}";

        fix-time = "sudo chronyc -a makestep";

        grep = "grep --color=auto";
        vim = "nvim";
        k = "kubectl";
      }
      // (
        if meta.isDesktop then
          {
            open = "xdg-open";
          }
        else
          { }
      );
    };
  };
}
