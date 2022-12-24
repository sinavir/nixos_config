{ ... }: {
  services.syncthing = rec {
    enable = true;
    devices.honor.id =
      "K5IKPPP-MTGTVAO-A3M2W6H-KY3GLR6-QKTOK3O-OYIA6GX-YVOOJQ5-NN4GLQA";
    devices.polaris.id =
      "QMJEDQK-KMFJFB3-G7LID3Z-NXUHLES-4BGJCUJ-IKK4WXI-YN3GLG7-E7IGHAG";
    devices.mintaka.id =
      "FBMRP2Z-L7FYBSC-45RUT36-VUD2Z4Z-7XMVRSG-RKY5USJ-XRTLJRS-FKUDLAJ";
    folders = {
      pwd = {
        id = "5sl9e-2btw0";
        devices = [ "mintaka" "honor" "polaris" ];
        path = "~/pwd";
      };
      Notes = {
        id = "75ujo-go7am";
        devices = [ "mintaka" "honor" "polaris" ];
        path = "~/Notes";
      };
    };
  };
}
