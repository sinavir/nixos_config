{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    comma
    agenix
    jq
    colmena
    dig
    git
    htop
    mosh
    screen
    npins
    nix-index
    nixpkgs-fmt
    tree
    unzip
    vim
    wget
    wireguard-tools
    borgbackup
  ];

  programs.mosh.enable = !(builtins.elem config.networking.hostName []);
  programs.mtr.enable = true;

  programs.vim.defaultEditor = true;
}
