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
    nslookup
    tree
    nix-index
    comma
  ];

  programs.mosh.enable = builtins.elem config.networking.hostname [ "proxima" "algedi" "rigel" ];
  programs.mtr.enable = true;

  programs.vim.defaultEditor = true;
}
