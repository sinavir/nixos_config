{ pkgs, config, lib, ... }:
{
  service.nginx = {
    enable = true;
    virtualHosts.localhost = {
      root = "/home/maurice/lychee-test";
      extraConfig = ''
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:${config.services.phpfpm.pools.lychee.socket};
        include ${pkgs.nginx}/conf/fastcgi_params;
        include ${pkgs.nginx}/conf/fastcgi.conf;
      '';
    };
  };
  services.phpfpm.pools.lychee = {
    user = "lychee";
    settings = {
      "listen.owner" = config.services.nginx.user;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 5;
      "php_admin_value[error_log]" = "stderr";
      "php_admin_flag[log_errors]" = true;
    };
  };
}
