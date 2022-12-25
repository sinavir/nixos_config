{ pkgs, config, ... }:
let 
  hostname = config.networking.hostName;
in
{
  imports = [
    ../modules/auto-upgrade.nix
    ./secrets
  ];
  system.autoUpgradeWithHooks = {
    enable = true;
    dates = "22:00";
    postSwitchHook = ''
      exitstatus=$?
      NTFY_PASS=$(cat ${config.agenix."ntfy-passwd".path})
      if [ $exitstatus -eq 0 ] ; then
        ${pkgs.curl}/bin/curl \
          -u misc:$NTFY_PASS
          -H "Title: Rebuild for ${hostname} successful" \
          -H "Tags: white_check_mark" \
          -d "What a wonderful day" \
          https://ntfy.sinavir.fr/server-daily-rebuild
      else
        ${pkgs.curl}/bin/curl \
          -u misc:$NTFY_PASS
          -H "Title: Rebuild for ${hostname} failed" \
          -H "Tags: warning" \
          -d "Exit status is $exitstatus" \
          https://ntfy.sinavir.fr/server-daily-rebuild
      '';
  };
}
