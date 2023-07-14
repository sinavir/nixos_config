let
  lib = import ./lib.nix;

  sources = import ./npins;

  agenix = sources.agenix + "/modules/age.nix";
  home-manager = sources.home-manager + "/nixos";

  metadata = {
    nodes = {
      polaris = {
        deployment = {
          targetHost = null;
          allowLocalDeployment = true;
        };
        imports = [agenix home-manager];
      };
      proxima = {
        deployment = {
          targetHost = "proxima";
        };
        imports = [agenix];
      };
      schedar = {
        deployment = {
          targetHost = "schedar";
        };
        imports = [agenix];
      };
      capella = {
        deployment = {
          targetHost = "capella";
          buildOnTarget = true;
        };
        imports = [agenix];
      };
    };
  };
in
  metadata
