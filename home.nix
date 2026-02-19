{ config, pkgs, ... }:

{
  home.username = "jeroen";
  home.homeDirectory = "/home/jeroen";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      fastfetch
      if ! command -v rustc &>/dev/null; then
        echo -e "\e[1;31m⚠ Rust is not installed! Run: rustup toolchain install stable\e[0m"
      fi
    '';
    shellAliases = {
      hconf = "nvim /home/jeroen/.config/home-manager/home.nix";
      hswitch = "home-manager switch";
      sudo = "sudo ";
      vi = "nvim ";

    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "jeroen";
    settings.user.email = "jeroen.vanrenterghem@student.hogent.be";
  };

  home.file.".config/nvim/lua/keymaps.lua".text = ''
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
    vim.keymap.set("n", "J", "mzJ`z")
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")
    vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
    vim.keymap.set("x", "<leader>p", [["_dP]])
    vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
    vim.keymap.set("n", "<leader>Y", [["+Y]])
    vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
    vim.keymap.set("i", "<C-c>", "<Esc>")
    vim.keymap.set("n", "Q", "<nop>")
  '';

  home.file.".config/nvim/lua/options.lua".text = ''
    vim.opt.relativenumber = true
    vim.opt.number = true
    vim.opt.syntax = "on"
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.smartindent = true
    vim.opt.wrap = false
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 8
    vim.opt.updatetime = 50
  '';

  home.file.".config/nvim/init.lua".text = ''
    require("keymaps")
    require("options")
  '';

  home.file.".config/ghostty/config".text = ''
    shell-integration = bash 
    font-family = JetBrains Mono
    theme = Dracula
    mouse-hide-while-typing = true
    scrollback-limit = 1000000
    
    keybind = ctrl+n=new_window
    
    keybind = ctrl+h=goto_split:left
    keybind = ctrl+j=goto_split:bottom
    keybind = ctrl+k=goto_split:top
    keybind = ctrl+l=goto_split:right
    
    keybind = ctrl+a>h=new_split:left
    keybind = ctrl+a>j=new_split:down
    keybind = ctrl+a>k=new_split:up
    keybind = ctrl+a>l=new_split:right
    keybind = ctrl+a>f=toggle_split_zoom
    
    keybind = ctrl+a>n=next_tab
    keybind = ctrl+a>p=previous_tab
    
    keybind = super+r=reload_config
    
    window-save-state = always
    background-opacity = 0.95
  '';

  home.packages = with pkgs; [
    btop
    clang
    curl
    duckdb
    fastfetch
    # gcc
    git
    gnumake
    go
    home-manager
    jetbrains.idea-ultimate
    jq
    just
    kdePackages.kate
    lazygit
    ninja
    python313
    python313Packages.virtualenv
    ripgrep
    ruff    
    rustup
    uv
    vscode
    wget
    xq
    zig
];

  home.sessionVariables = {
    GTK_IM_MODULE = "simple";
  };
}
