{config, ...}: {
  services.tailscale.enable = true;
  systemd.services.tailscale-up = {
    serviceConfig.Type = "oneshot";
    wantedBy = ["multi-user.target"];
    after = ["tailscaled.service"];
    wants = ["tailscaled.service"];
    script = "${config.services.tailscale.package}/bin/tailscale up --login-server https://vpn.sinavir.fr --auth-key file:${config.age.secrets."vpn_preauth".path}";
  };
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
