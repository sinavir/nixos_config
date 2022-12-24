{ ... }: {
  services.syncthing = rec {
    enable = true;
    devices.honor.id =
      "K5IKPPP-MTGTVAO-A3M2W6H-KY3GLR6-QKTOK3O-OYIA6GX-YVOOJQ5-NN4GLQA";
    devices.polaris.id =
      "3QBL655-PJILD3U-MOIFIJM-ZBS4EH4-5AIVYLK-RMCNYI7-3FHRMFP-VFD6CQE";
    folders = {
      pwd = {
        id = "5sl9e-2btw0";
        devices = [ "honor" "polaris" ];
        path = "~/pwd";
      };
      Notes = {
        id = "75ujo-go7am";
        devices = [ "honor" "polaris" ];
        path = "~/Notes";
      };
    };
  };
}
