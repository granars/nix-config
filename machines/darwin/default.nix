{ ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
      settings = {
      max-jobs = "auto";
      trusted-users = [
        "root"
        "granar"
        "@admin"
      ];
    };
  };
}

#       # Automatic Cleanup
#       nix.gc.automatic = true;
#       nix.gc.interval = {
#         Hour = 3;
#       };
#       nix.gc.options = "--delete-older-than 10d";
#       nix.optimise.automatic = true;
      