{ ... }: {
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
}
