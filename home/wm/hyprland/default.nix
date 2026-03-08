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
      STATUS_FILE="''${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.status"

      set_status() {
          printf '%s\n' "$1" > "$STATUS_FILE"
      }

      if pgrep -x wf-recorder > /dev/null; then
          set_status '{"status":"OFF","alt":"idle"}'
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
          set_status '{"status":"REC","alt":"recording"}'
          cleanup() {
              set_status '{"status":"OFF","alt":"idle"}'
          }
          trap cleanup EXIT INT TERM HUP
          wf-recorder -o "$FOCUSED_MONITOR" -f "$VIDEO_DIR/$(date +'%Y-%m-%d-%H%M%S.mp4')"
      fi
    '';
  };

  home.file.".local/bin/recording-status" = {
    executable = true;
    text = ''
      #!/bin/sh
      STATUS_FILE="''${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.status"

      if [ -r "$STATUS_FILE" ]; then
          cat "$STATUS_FILE"
      else
          printf '%s\n' '{"status":"OFF","alt":"idle"}'
      fi
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
