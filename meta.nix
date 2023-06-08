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
        imports = [ agenix home-manager ];
      };
      proxima = {
        deployment = {
          targetHost = "sinavir.fr";
        };
        imports = [ agenix ];
      };
      capella = {
        deployment = {
          targetHost = "capella.server";
        };
        imports = [ agenix ];
      };
    };
  };
in metadata
