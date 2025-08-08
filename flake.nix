{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs"; # set same version of nixpkgs
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      #inputs.nixpkgs.follows = "nixpkgs"; # set same version of nixpkgs
    };
    # ある程度まとまったらgithubのurl二変更
    kickstart-nixvim.url = "path:/home/watanabe/.dotfiles/home/kickstart.nixvim";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      hyprland,
      hyprland-plugins,
      nixos-hardware,
      fenix,
      nixvim,
      kickstart-nixvim,
      ...
    }:
    {
      packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-config/configuration.nix
          hyprland.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          home-manager.nixosModules.home-manager
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              fenix.overlays.default
              (final: prev: {
                hyprland-plugins = {
                  hyprbars = hyprland-plugins.packages.${prev.system}.hyprbars;
                };
              })
            ];
            environment.systemPackages = with pkgs; [
              (pkgs.fenix.stable.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
                "rust-analyzer"
              ])
            ];
          })
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.watanabe = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit nixvim kickstart-nixvim hyprland; };
          }
        ];
      };
    };
}