{ pkgs, ... }:
{
  imports = [
    ./hypridle.nix
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
    cliphist # clipboard history
    hyprpanel # status bar
    hyprlock # lock screen
    libsecret # keyring
    procps # for pkill
    xdg-user-dirs # for xdg-user-dir
  ];

  services = {
    gnome-keyring.enable = true;
  };

  home.file.".local/bin/toggle-recorder" = {
    executable = true;
    text = ''
      #!/bin/sh
      if pgrep -x wf-recorder > /dev/null; then
          pkill -SIGINT wf-recorder
      else
          # Get the name of the monitor with the active workspace
          FOCUSED_MONITOR=$(hyprctl activeworkspace | head -n 1 | awk '{print $7}' | cut -d':' -f1)

          # Exit if no monitor is found
          if [ -z "$FOCUSED_MONITOR" ]; then
              exit 1
          fi

          VIDEO_DIR=$(xdg-user-dir VIDEOS)
          mkdir -p "$VIDEO_DIR"
          wf-recorder -o "$FOCUSED_MONITOR" -f "$VIDEO_DIR/$(date +'%Y-%m-%d-%H%M%S.mp4')"
      fi
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}