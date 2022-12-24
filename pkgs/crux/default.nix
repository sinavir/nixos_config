{ callPackage, buildPythonApplication, fetchgit, asyncio-mqtt }:
let bottom = callPackage ./bottom.nix { };
in buildPythonApplication rec {
  pname = "crux";
  version = "1.0";
  doCheck = false;
  src = fetchgit {
    url = "https://git.eleves.ens.fr/hackens/crux.git";
    rev = "1.0";
    sha256 = "0c3j0lfi882xx6mq2gid1if465rk6mn2ahsbabr32pq3lnh6xjaa";
  };
  propagatedBuildInputs = [ bottom asyncio-mqtt ];
}
