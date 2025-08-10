{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
  services.xserver.enable = true;
}
