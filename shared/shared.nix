{ config, ... }:
{
  imports = [ ../modules/shared.nix ];
  shared.wg = {
    peers = {
      algedi = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/algedi);
        allowedIPs = [ "${config.shared.wg.all4}2/32" "${config.shared.wg.all6}2/128" ];
        endpoint = "rz.sinavir.fr:51820";
      };
      mintaka = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/mintaka);
        allowedIPs = [ "${config.shared.wg.all4}4/32" "${config.shared.wg.all6}4/128" ];
      };
      polaris = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/polaris);
        allowedIPs = [ "${config.shared.wg.all4}3/32" "${config.shared.wg.all6}3/128" ];
      };
      proxima = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/proxima);
        allowedIPs = [ "${config.shared.wg.all4}0/24" "${config.shared.wg.all6}0/64" ];
        endpoint = "sinavir.fr:51820";
      };
      ap-unifi = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/ap-unifi);
        allowedIPs = [ "10.100.5.0/24" ];
      };
      elnath = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/elnath);
        allowedIPs = [ "${config.shared.wg.all4}5/32" "${config.shared.wg.all6}5/128" ];
      };
    };
    all4 = "10.100.1.";
    all6 = "2001:470:1f13:128::";
  };
}
