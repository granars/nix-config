{ ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
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
      