{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    htop
    mosh
    niv
    unzip
    dig
    tree
    nix-index
    comma
  ];

  programs.mosh.enable = builtins.elem config.networking.hostName [ "proxima" "algedi" "rigel" ];
  programs.mtr.enable = true;

  programs.vim.defaultEditor = true;
}
