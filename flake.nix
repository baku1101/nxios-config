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
    ags = {
      url = "github:Aylur/ags";
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
    # packages (not in nixpkgs)
    cargo-compete = {
      url = "github:satler-git/sb-nix-cargo-compete";
      # Hashがかわる
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      hyprland-plugins,
      nixos-hardware,
      fenix,
      nixvim,
      ags,
      ...
    }@inputs:
    {
      packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-config/configuration.nix
          hyprland.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          home-manager.nixosModules.home-manager
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                fenix.overlays.default
                (final: prev: {
                  hyprland-plugins = {
                    hyprbars = hyprland-plugins.packages.${prev.system}.hyprbars;
                  };
                })
                (final: prev: {
                  codex = prev.stdenvNoCC.mkDerivation (finalAttrs: {
                    pname = "codex";
                    version = "0.111.0";
                    src = prev.fetchurl {
                      url = "https://github.com/openai/codex/releases/download/rust-v${finalAttrs.version}/codex-x86_64-unknown-linux-musl.tar.gz";
                      hash = "sha256-pTLmtQHPUDET0wDfs+AoqGqukKOAOyYgvEuXp1B11lg=";
                    };
                    dontConfigure = true;
                    dontBuild = true;
                    unpackPhase = ''
                      runHook preUnpack
                      tar -xzf $src
                      runHook postUnpack
                    '';
                    installPhase = ''
                      runHook preInstall
                      install -Dm755 codex-x86_64-unknown-linux-musl $out/bin/codex
                      runHook postInstall
                    '';
                    meta = with prev.lib; {
                      description = "Codex CLI";
                      homepage = "https://github.com/openai/codex";
                      license = licenses.asl20;
                      platforms = [ "x86_64-linux" ];
                      mainProgram = "codex";
                    };
                  });
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
            }
          )
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.watanabe = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs nixvim hyprland; };
          }
        ];
      };
    };
}
