{ pkgs, ... }:
{
  imports = [
   ./hyprpanel.nix
   ./settings.nix
   ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    wofi # launcher
    grimblast # screenshot
    wireplumber # screens sharing
    wf-recorder # screen recorder
    wl-clipboard # clipboard manager
    cliphist #clipboard history
    hyprpanel # status bar
    hyprlock # lock screen
    libsecret # keyring
  ];

  services = {
    gnome-keyring.enable = true;
  };
}
