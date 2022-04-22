{ ... }: {
  users.groups.maurice.gid=1000;
  users.mutableUsers = false;
  users.users.maurice = {
    isNormalUser = true;
    group="maurice";
    uid=1000;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    home = "/home/maurice";
    openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDz7k1nXGGprwTzzZRtPN6gnEmhp1OvLDt6NfRUjeBTjBJli3TJ/oTOACOGu9FMGMi4K4nPGSW1oHlEFloO40Ya3flIN2LdGI5cJvC72SD+eW3nzurX1E7QACKSK7/jq+cQmjwd1vahD8POkg89DoonD48OtidS1Zxnv0IriApReiZ1hPJ/RHBqVGPmSurfGzrBG2Y9z5P8PbEoMrio1RF3TYQukSmB6ZQqNVKW7fNd3lkCqXqzbqQUgEiArljHrYkU6W1GiIQxpQUhTLcJNWhzhfmzl9L5AJpZWpGOUpAk8rXgI75qZ26DmzglYDghjb+q4zV08hbptMGWfdrploH171TpPUuhP5KZGtniFGunU7n3ZMVJSbajB1mj76cOedyYn9EQ5zeGGbr2AB1B+XxbZ0xUEfltZpWs7JBsGtjZGoI7Jlo2Oe2NNbXHUKz4Y5TbzyhMb4V300XPdb/YbaO3j8dzGYOtKvdtlXrEl2dK/vqQwfekolsukKiVPHiQUZLam1I1qvXKg/sDe+jmatZGECBGtsojj4DCR/K+m96ct8nn6v16N2xKQ8sP8kmjIGjuLhjyvglt+NCb2RNA3ezHXCvwv2yPZoSkxeOIrK8PnqQymWhA1ghkVz/iQhW5QEH4bnrn0NgtoOewpeNia8lRR4S4z62KBBfs+1nOhQ/FNw== maurice@polaris"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1FilN5OcWKTulTGs8HA0fHZMW9vpnt5tSkH3N1fI7m u0_a208@localhost"
      ];
  };
}
