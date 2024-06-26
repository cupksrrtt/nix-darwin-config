{
  description = "Cup nix config for macos";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = { url = "github:zhaofengli-wip/nix-homebrew"; };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    #Language
    nodejs-lts-nixpkgs.url =
      "github:nixos/nixpkgs/9a9dae8f6319600fa9aebde37f340975cab4b8c0";
    gleam-nixpkgs.url =
      "github:nixos/nixpkgs/f945939fd679284d736112d3d5410eb867f3b31c";
    erlang-nixpkgs.url =
      "github:nixos/nixpkgs/9a9dae8f6319600fa9aebde37f340975cab4b8c0";
    rebar3-nixpkgs.url =
      "github:nixos/nixpkgs/9a9dae8f6319600fa9aebde37f340975cab4b8c0";
    go-nixpkgs.url =
      "github:nixos/nixpkgs/58ae79ea707579c40102ddf62d84b902a987c58b";
    bun-nixpkgs.url =
      "github:nixos/nixpkgs/0837fbf227364d79cbae8fff2378125526905cbe";

  };
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core
    , homebrew-cask, home-manager, nixpkgs, nixvim, ... }@inputs:
    let
      system = [ "aarch64-darwin" ];
      nvim = nixvim.legacyPackages.aarch64-darwin.makeNixvim {
        globals = {
          mapleader = " ";
          backup = false;
          writebackup = false;
          swapfile = false;
        };

        clipboard.register = "unnamedplus";

        options = {
          encoding = "utf-8";
          fileencoding = "utf-8";
          autoindent = true;
          hlsearch = true;
          showcmd = true;
          cmdheight = 1;
          laststatus = 2;
          expandtab = true;
          hidden = false;
          scrolloff = 10;
          shell = "zsh";
          ignorecase = true;
          smarttab = true;
          breakindent = true;
          shiftwidth = 2;
          tabstop = 2;
          ai = true;
          si = true;
          wrap = false;
          backspace = "start,eol,indent";
          cursorline = true;
          winblend = 0;
          wildoptions = "pum";
          background = "dark";
          number = true;
          relativenumber = true;
        };

        plugins = {
          lsp = {
            enable = true;
            servers = {
              nil_ls.enable = true;
              tsserver.enable = true;
              eslint.enable = true;
              tailwindcss.enable = true;
              jsonls.enable = true;
              prismals.enable = true;
              html.enable = true;
              gopls.enable = true;
              gleam.enable = true;
              cssls.enable = true;
            };

            onAttach = ''
              vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
            '';

            keymaps = {
              diagnostic = { "<leader>do" = "open_float"; };
              lspBuf = {
                "<leader>dh" = "hover";
                "<leader>dr" = "references";
                "<leader>dd" = "definition";
                "<leader>di" = "implementation";
                "<leader>dt" = "type_definition";
                "<leader>ca" = "code_action";
              };
            };
          };

          nvim-cmp = {
            enable = true;
            autoEnableSources = true;
            mapping = {
              "<CR>" =
                "cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true,})";
              "<C-k>" = "cmp.mapping.select_prev_item()";
              "<C-j>" = "cmp.mapping.select_next_item()";
            };

            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
            ];

            snippet.expand = {
              __raw = ''
                function(args)
                  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end
              '';
            };
          };

          cmp-nvim-lsp.enable = true;

          cmp_luasnip.enable = true;

          luasnip.enable = true;
          luasnip.fromVscode = [ { } ];

          lspkind = {
            enable = true;
            mode = "text";
            cmp = { enable = true; };
          };

          telescope.enable = true;

          treesitter = {
            enable = true;
            nixGrammars = true;
            ensureInstalled = "all";
          };

          gitsigns = {
            enable = true;
            currentLineBlame = true;
          };

          ts-autotag.enable = true;

          nvim-autopairs.enable = true;

          toggleterm.enable = true;

          conform-nvim = {
            enable = true;
            formattersByFt = {
              lua = [ "stylua" ];
              javascript = [[ "prettierd" "prettier" ]];
              javascriptreact = [[ "prettierd" "prettier" ]];
              typescript = [[ "prettierd" "prettier" ]];
              typescriptreact = [[ "prettierd" "prettier" ]];
              nix = [ "nixfmt" ];
            };
            formatOnSave = {
              lspFallback = true;
              timeoutMs = 200;
            };
          };

        };

        colorschemes = {
          tokyonight = {
            enable = true;
            style = "night";
          };
        };

        keymaps = [

          {
            action = "<C-\\><C-n>";
            key = "<ESC>";
            mode = "t";
          }
          {
            action = ":Explore<CR>";
            key = "<leader>fb";
            mode = "n";
          }
          {
            action = ":Telescope find_files<CR>";
            key = "<leader>ff";
            mode = "n";
          }
          {
            action = "<C-a>";
            key = "+";
            mode = "n";

          }
          {
            action = "<C-x>";
            key = "-";
            mode = "n";
          }
          {
            action = "gg<S-v>G";
            key = "<C-a>";
            mode = "n";
          }
          {
            action = ":split<CR>";
            key = "<leader>sh";
            mode = "n";
          }
          {
            action = ":vsplit<CR>";
            key = "<leader>sv";
            mode = "n";
          }
          {
            action = "<C-w>h";
            key = "sh";
            mode = "n";
          }
          {
            action = "<C-w>j";
            key = "sj";
            mode = "n";
          }
          {
            action = "<C-w>k";
            key = "sk";
            mode = "n";
          }
          {
            action = "<C-w>l";
            key = "sl";
            mode = "n";
          }
          {
            action = ":bp<CR>";
            key = "<C-h>";
            mode = "n";
          }
          {
            action = ":bn<CR>";
            key = "<C-l>";
            mode = "n";
          }
          {
            action = ":ToggleTerm<CR>";
            key = "tt";
            mode = "n";
          }
          {
            action = ":Gitsigns preview_hunk<CR>";
            key = "<leader>gt";
            mode = "n";
          }
        ];
      };
      forAllSystem = f: nixpkgs.lib.genAttrs (system) f;
      devShell = system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [ git ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="default"
                clear 
                exec ${tmux}/bin/tmux
              '';
            };
          "node" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [
                git
                inputs.nodejs-lts-nixpkgs.legacyPackages.${system}.nodejs_20
                zsh
                prettierd
                typescript
              ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="node"
                clear 
                exec ${tmux}/bin/tmux
              '';
            };
          "bun" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [
                git
                inputs.bun-nixpkgs.legacyPackages.${system}.bun
                zsh
                prettierd
                typescript
              ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="bun"
                clear 
                exec ${tmux}/bin/tmux
              '';
            };
          "nix" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [ git zsh nixfmt ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="nix"
                clear
                exec ${tmux}/bin/tmux
              '';
            };
          "gleam" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [
                git
                zsh
                inputs.gleam-nixpkgs.legacyPackages.${system}.gleam
                inputs.erlang-nixpkgs.legacyPackages.${system}.erlang_26
                inputs.rebar3-nixpkgs.legacyPackages.${system}.rebar3
              ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="gleam"
                clear
                exec ${tmux}/bin/tmux
              '';
            };
          "go" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [
                git
                zsh
                inputs.go-nixpkgs.legacyPackages.${system}.go_1_22
              ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="go"
                clear
                exec ${tmux}/bin/tmux
              '';
            };
          "go:htmx" = with pkgs;
            mkShell {
              buildInputs = [ nvim ];
              nativeBuildInputs = with pkgs; [
                git
                zsh
                inputs.go-nixpkgs.legacyPackages.${system}.go_1_22
                inputs.nodejs-lts-nixpkgs.legacyPackages.${system}.nodejs_20
                air
              ];
              shellHook = with pkgs; ''
                export DEV_SHELL_ENV="go:htmx"
                clear
                exec ${tmux}/bin/tmux
              '';
            };

        };
      mkApp = scriptName: system: {
        type = "app";
        program = "${
            (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
              #!/usr/bin/env bash
              PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
              echo "Running ${scriptName} for ${system}"
              exec ${self}/apps/${system}/${scriptName}
            '')
          }/bin/${scriptName}";
      };
      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
      };

    in {
      devShells = forAllSystem devShell;

      apps = nixpkgs.lib.genAttrs system mkDarwinApps;

      darwinConfigurations = let user = "cup";
      in {
        macos = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "${user}";
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./config
          ];
        };
      };
    };
}

