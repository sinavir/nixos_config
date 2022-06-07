{ ... }:
{
  services.syncthing = rec {
    enable = true;
    devices.honor.id = "K5IKPPP-MTGTVAO-A3M2W6H-KY3GLR6-QKTOK3O-OYIA6GX-YVOOJQ5-NN4GLQA";
    devices.polaris.id = "YHPG5F4-YSL6GOL-LUVLAST-46BRVNH-LO7P5KF-IZSWBIY-R4G3QZ5-YJPGIQ3";
    devices.mintaka.id = "QZ3QBKX-YTHW5RB-T33URQX-L77UXW4-Q344EPF-RRC3Y27-EHVBNN4-7RGRPAJ";
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
