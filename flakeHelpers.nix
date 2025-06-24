inputs:
let
  getMachineHomeModule = path:
    if builtins.pathExists path then [ path ] else [ ];

  homeManagerCfg = userPackages: extraImports: {
    home-manager.useGlobalPkgs = false;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.granar.imports = [
      inputs.agenix.homeManagerModules.default
      inputs.nix-index-database.hmModules.nix-index
      ./users/granar/dots.nix
    ] ++ extraImports;
    home-manager.backupFileExtension = "bak";
    home-manager.useUserPackages = userPackages;
  };
in
{
  mkDarwin = machineHostname: nixpkgsVersion: extraHmModules: extraModules: {
    darwinConfigurations.${machineHostname} = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        inputs.agenix.darwinModules.default
        ./machines/darwin
        ./machines/darwin/${machineHostname}
        inputs.mac-app-util.darwinModules.default
        inputs.home-manager-unstable.darwinModules.home-manager
        (nixpkgsVersion.lib.attrsets.recursiveUpdate (homeManagerCfg true extraHmModules) {
          home-manager.users.granar.home.homeDirectory = nixpkgsVersion.lib.mkForce "/Users/granar";
        })
      ];
    };
  };

  mkNixos = machineHostname: nixpkgsVersion: extraModules: rec {
    deploy.nodes.${machineHostname} = {
      hostname = machineHostname;
      profiles.system = {
        user = "root";
        sshUser = "granar";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.${machineHostname};
      };
    };

    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./machines/nixos/_common
        ./machines/nixos/${machineHostname}
        inputs.catppuccin.nixosModules.catppuccin
        inputs.agenix.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
        ./users/granar
        (homeManagerCfg false ( 
          getMachineHomeModule ./machines/nixos/${machineHostname}/home.nix
        ))
      ] ++ extraModules;
    };
  };

  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) { };
}
