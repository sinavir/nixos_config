{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    comma
    dig
    git
    htop
    mosh
    screen
    niv
    nix-index
    nixpkgs-fmt
    tree
    unzip
    vim
    wget
    wireguard-tools
    borgbackup
  ];

  programs.mosh.enable = builtins.elem config.networking.hostName [ "mintaka" "proxima" "algedi" "rigel" ];
  programs.mtr.enable = true;

  programs.vim.defaultEditor = true;
}
