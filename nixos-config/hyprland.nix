{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland requires a graphical session to be available
  services.xserver.enable = true;
  #  services.xserver.displayManager.gdm.enable = true;
  #  services.xserver.desktopManager.gnome.enable = true;
}
