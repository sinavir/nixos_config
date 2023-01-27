{ pkgs, config, lib, ... }:
{
  programs.ssh.startAgent = true;
  services.openssh.permitRootLogin = "no";
}
