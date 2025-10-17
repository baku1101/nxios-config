{ pkgs, lib, ... }:
{
  # input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
      kdePackages.fcitx5-qt
    ];
    fcitx5.waylandFrontend = true;
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
  };
}
