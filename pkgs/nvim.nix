{ pkgs, ... }:
{
  vim = {
    # Experimental feature
    enableLuaLoader = true;

    #------------------------------------------------------------------------------
    # CORE EDITOR SETTINGS
    #------------------------------------------------------------------------------
    options = {
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      clipboard = "unnamedplus";

      # Folding Options
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
    };

    #------------------------------------------------------------------------------
    # APPEARANCE
    #------------------------------------------------------------------------------
    # Theme configuration
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    # UI enhancements
    ui = {
      noice.enable = true;
      nvim-ufo.enable = true;
      borders = {
        enable = true;
        plugins.lspsaga.enable = true;
      };
    };

    # Visual elements
    visuals.nvim-web-devicons.enable = true;

    # Status and display components
    mini = {
      basics.enable = true;
      statusline.enable = true;
      icons.enable = true;
    };

    #------------------------------------------------------------------------------
    # LANGUAGE SUPPORT & LSP
    #------------------------------------------------------------------------------
    languages = {
      enableTreesitter = true;
      enableFormat = true;

      # Language servers
      astro.enable = true;
      bash.enable = true;
      css.enable = true;
      helm.enable = true;
      html.enable = true;
      nix = {
        enable = true;
        format.type = "nixfmt";
      };
      python.enable = true;
      rust.enable = true;
      tailwind.enable = true;
      ts.enable = true;

      # Markdown support
      markdown = {
        enable = true;
        extensions.render-markdown-nvim = {
          enable = true;
          setupOpts = {
            file_types = [
              "markdown"
              "Avante"
            ];
          };
        };
      };

      yaml.enable = true;
    };

    # LSP configuration
    lsp = {
      enable = true;
      formatOnSave = true;
      lspsaga.enable = true;
    };

    # Diagnostic tools
    diagnostics = {
      enable = true;
      config.virtual_lines = true;
      nvim-lint.enable = true; # Prevents errors from other plugins
    };

    #------------------------------------------------------------------------------
    # CODE FORMATTING
    #------------------------------------------------------------------------------
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters_by_fs = {
          astro = [
            "prettierd"
            "eslint_d"
          ];
          nix = [ "nixfmt-plus" ];
        };
      };
    };

    #------------------------------------------------------------------------------
    # COMPLETION & ASSISTANCE
    #------------------------------------------------------------------------------
    # Auto-completion
    autocomplete.blink-cmp = {
      enable = true;
      mappings = {
        close = null;
        complete = null;
      };
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

    # Auto-pairs and assistance
    autopairs.nvim-autopairs.enable = true;
    assistant.copilot.enable = true;
    assistant.avante-nvim = {
      enable = true;
      setupOpts = {
        provider = "copilot";
        providers = {
          copilot = {
            model = "claude-3.5-sonnet";
            endpoint = "https://api.githubcopilot.com";
            allow_insecure = false;
            timeout = 10 * 60 * 1000;
            max_completion_tokens = 1000000;
            reasoning_effort = "high";
            extra_request_body = {
              temperature = 0;
            };
          };
        };
      };
    };

    # Comments
    comments.comment-nvim.enable = true;
    notes.todo-comments.enable = true;

    #------------------------------------------------------------------------------
    # NAVIGATION & FILE MANAGEMENT
    #------------------------------------------------------------------------------
    # File explorer
    filetree.neo-tree = {
      enable = true;
      setupOpts.filesystem.hijack_netrw_behavior = "open_current";
    };

    # Search
    telescope = {
      enable = true;
      mappings.resume = null;
    };

    #------------------------------------------------------------------------------
    # GIT INTEGRATION
    #------------------------------------------------------------------------------
    git.gitsigns.enable = true;

    #------------------------------------------------------------------------------
    # KEYBINDINGS
    #------------------------------------------------------------------------------
    binds.whichKey.enable = true;

    keymaps = [
      # Git
      {
        key = "<leader>gg";
        mode = "n";
        silent = true;
        action = "function() Snacks.lazygit() end";
        lua = true;
        desc = "Show LazyGit window";
      }
      # File navigation
      {
        key = "<leader>fr";
        mode = "n";
        silent = true;
        action = "<cmd>Telescope oldfiles<CR>";
        desc = "Show Telescopes old files";
      }
      # File explorer
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
      # LSP actions
      {
        key = "caa";
        mode = "n";
        silent = true;
        action = "<cmd>Lspsaga code_action<CR>";
        desc = "Lsp Sage Code action";
      }
      {
        key = "cgg";
        mode = "n";
        silent = true;
        action = "<cmd>Lspsaga goto_definition<CR>";
        desc = "Lsp Sage Goto definition";
      }
    ];

    #------------------------------------------------------------------------------
    # PLUGINS
    #------------------------------------------------------------------------------
    # Custom plugins
    lazy.plugins = {
      "yuck.vim" = {
        package = pkgs.vimPlugins.yuck-vim;
      };
      "colorful-menu.nvim" = {
        package = pkgs.vimPlugins.colorful-menu-nvim;
        setupOpts = {
          ls = {
            lua_ls = {
              arguments_hl = "@comment";
            };
            ts_ls = {
              extra_info_hl = "@comment";
            };
          };
          fallback_highlight = "@variable";
          max_width = 60;
        };
      };
    };

    #------------------------------------------------------------------------------
    # UTILITIES
    #------------------------------------------------------------------------------
    # Snacks utilities
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        lazygit.enable = true;
        bigfile.enable = true;
        notifier.enable = true;
        git.enable = true;
        gitbrowser.enable = true;
        scroll.enable = true;
        indent = {
          enable = true;
          indent.only_scope = true;
        };
        statuscolumn.enable = true;
      };
    };
  };
}
