{ ... }:
let port = 3000;
in {
  services.gitea = {
    enable = true;
    httpAddress = "127.0.0.1";
    httpPort = port;
    database.type = "postgres";
    disableRegistration = true;
  };
  services.nginx = { };
}
