{ config, ... }:
{
  imports = [ ../modules/shared.nix ];
  shared.wg = {
    peers = {
      algedi = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/algedi);
        allowedIPs = [ "${config.shared.wg.all4}2/24" "${config.shared.wg.all6}2/64" ];
        endpoint = "rz.sinavir.fr:51820";
      };
      polaris = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/polaris);
        allowedIPs = [ "${config.shared.wg.all4}3/24" "${config.shared.wg.all6}3/64" ];
      };
      proxima = {
        publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/proxima);
        allowedIPs = [ "${config.shared.wg.all4}0/24" "${config.shared.wg.all6}0/64" ];
        endpoint = "sinavir.fr:51820";
      };
    };
    all4 = "10.100.1.";
    all6 = "2001:470:1f13:128::";
  };
}
