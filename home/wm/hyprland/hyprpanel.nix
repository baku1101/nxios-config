{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    power-profiles-daemon
    upower
    jq
    vulnix
    pavucontrol
    pulseaudio
    brightnessctl
    btop
    gcolor3
  ];
  programs.ags = {
    enable = true;
  };
  programs.hyprpanel = {
    enable = true;
    settings = {
      "bar.layouts" =
        let
          layout =
            {
              showBattery ? true,
            }:
            {
              "left" = [
                "dashboard"
                "workspaces"
                "windowtitle"
                "custom/recording-status"
                "custom/vulstat"
                "storage"
              ]
              ++ (if showBattery then [ "battery" ] else [ ]);
              "middle" = [
                "media"
              ];
              "right" = [
                "cpu"
                "ram"
                "volume"
                "network"
                "bluetooth"
                "systray"
                "clock"
                "notifications"
              ];
            };
          none = {
            "left" = [ ];
            "middle" = [ ];
            "right" = [ ];
          };
        in
        {
          "0" = layout { };
          "1" = layout { };
          "2" = layout { };
          "3" = layout { };
        };

      theme.name = "catppuccin_mocha";
      theme.bar.floating = false;
      theme.bar.buttons.enableBorders = true;
      theme.bar.transparent = true;
      theme.font.size = "14px";
      menus.clock.time.military = true;
      menus.clock.time.hideSeconds = false;
      bar.clock.format = "%y/%m/%d  %H:%M";
      bar.media.show_active_only = true;
      bar.notifications.show_total = false;
      theme.bar.buttons.modules.ram.enableBorder = false;
      bar.launcher.autoDetectIcon = true;
      bar.battery.hideLabelWhenFull = true;
      menus.dashboard.controls.enabled = false;
      menus.dashboard.shortcuts.enabled = true;
      menus.clock.weather.enabled = true;
      menus.dashboard.shortcuts.right.shortcut1.command = "${pkgs.gcolor3}/bin/gcolor3";
      menus.media.displayTime = true;
      menus.power.lowBatteryNotification = true;
      bar.volume.rightClick = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      bar.volume.middleClick = "pavucontrol";
      bar.media.format = "{title}";
    };
  };

  # modules.json の生成と配置
  xdg.configFile."hyprpanel/modules.json".source = pkgs.writeText "modules.json" (
    builtins.toJSON {
      "custom/recording-status" = {
        icon = "";
        label = "{status}";
        execute = "recording-status";
        interval = 100;
        actions = {
          onLeftClick = "toggle-recorder";
        };
      };
      "custom/vulstat" = {
        icon = "󰋼"; # vulnixのアイコン
        label = "{}"; # JSON出力の場合
        execute = "jq '[.[].cvssv3_basescore | to_entries | add | select(.value > 5)] | length' <<< $(vulnix -S --json)";
        interval = 600000;
      };
    }
  );

  # Custom module styles
  xdg.configFile."hyprpanel/modules.scss".text = ''
    @include styleModule(
      'cmodule-recording-status',
      (
        'text-color': #F38BA8, // Catppuccin Red
        'icon-color': #F38BA8
      )
    );
    @include styleModule(
      'cmodule-vulstat',
      (
        'text-color': #FAB387, // Catppuccin Peach
        'icon-color': #FAB387
      )
    );
  '';

}
