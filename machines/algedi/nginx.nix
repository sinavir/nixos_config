{ ... }:
{
  services.nginx = {
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    appendHttpConfig = "add_header X-Robots-Tag noindex, nofollow, nosnippet, noarchive";
  };
}

