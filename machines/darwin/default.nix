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
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
      options = "--delete-older-than 10d";
    };
    optimise.automatic = true;
  };
}