{ pkgs, ... }:
{
  vim = {
    options = {
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      clipboard = "unnamedplus";
    };

    # Styling
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    # Keymaps
    keymaps = [
      {
        key = "<leader>gg";
        mode = "n";
        silent = true;
        action = "function() Snacks.lazygit() end";
        lua = true;
        desc = "Show LazyGit window";
      }
      {
        key = "<leader>fr";
        mode = "n";
        silent = true;
        action = "<cmd>Telescope oldfiles<CR>";
        desc = "Show Telescopes old files";
      }
      {
        key = "<leader>m";
        mode = "n";
        silent = true;
        action = "<cmd>Neotree toggle<CR>";
        desc = "Toggle filetree";
      }
      {
        key = "<leader>n";
        mode = "n";
        silent = true;
        action = "<cmd>Neotree reveal<CR>";
        desc = "Reveal filetree";
      }
    ];
    binds.whichKey.enable = true;

    # LSP
    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;

      # LSP servers
      astro.enable = true;
      bash.enable = true;
      nix.enable = true;
      nix.format.type = "nixfmt";
      python.enable = true;
      rust.enable = true;
      ts.enable = true;
      tailwind.enable = true;
    };

    # Custom Plugins
    lazy.plugins = {
      "yuck.vim" = {
        package = pkgs.vimPlugins.yuck-vim;
      };
      "avante.nvim" = {
        package = pkgs.vimPlugins.avante-nvim;
        setupModule = "avante";
        #event = "VeryLazy";
        #lazy = false;
        setupOpts = {
          provider = "copilot";
          copilot = {
            model = "claude-3.7-sonnet";
            endpoint = "https://api.githubcopilot.com";
            allow_insecure = false;
            timeout = 10 * 60 * 1000;
            temperature = 0;
            max_completion_tokens = 1000000;
            reasoning_effort = "high";
          };
        };
      };
    };

    # Options
    lsp = {
      enable = true;

      formatOnSave = true;
      lspsaga.enable = true;
    };

    autocomplete.blink-cmp = {
      enable = true;
      mappings.close = null;
      mappings.complete = null;
      sourcePlugins = {
        copilot = {
          enable = true;
          package = pkgs.vimPlugins.blink-copilot;
          module = "blink-copilot";
        };
      };
      setupOpts.sources.providers = {
        copilot = {
          name = "copilot";
          module = "blink-copilot";
          score_offset = 100;
          async = true;
        };
      };
    };
    autopairs.nvim-autopairs.enable = true;
    assistant.copilot.enable = true;

    # UI
    ui.noice.enable = true;
    notes.todo-comments.enable = true;
    comments.comment-nvim.enable = true;
    visuals.nvim-web-devicons.enable = true;

    # mini.nvim
    mini = {
      basics.enable = true;
      statusline.enable = true;
      icons.enable = true;
    };

    # Git
    git.gitsigns.enable = true;

    # File Search
    telescope = {
      enable = true;
      mappings.resume = null;
    };

    # File Tree
    filetree.neo-tree = {
      enable = true;
      setupOpts.filesystem.hijack_netrw_behavior = "open_current";
    };

    diagnostics.nvim-lint.enable = true; # Enabling this to stop the errors from other plugins

    # Snacks
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        lazygit.enable = true;
        bigfile.enable = true;
        notifier.enale = true;
        git.enable = true;
        gitbrowser.enable = true;
        scroll.enable = true;
        indent.enable = true;
        indent.indent.only_scope = true;
        statuscolumn.enable = true;
      };
    };
  };
}
