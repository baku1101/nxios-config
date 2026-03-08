{
  pkgs,
  config,
  ...
}:
let
  codexNotify = pkgs.writeShellScript "codex-notify" ''
    payload="''${1:-{}}"

    title="$(${pkgs.jq}/bin/jq -r '
      .title // .summary // .event // .type // "Codex"
    ' <<< "$payload" 2>/dev/null)"
    body="$(${pkgs.jq}/bin/jq -r '
      .message // .body // .subtitle // .status // ""
    ' <<< "$payload" 2>/dev/null)"

    if [ -z "$title" ] || [ "$title" = "null" ]; then
      title="Codex"
    fi

    if [ "$body" = "null" ]; then
      body=""
    fi

    ${pkgs.libnotify}/bin/notify-send "$title" "$body"
    ${pkgs.pulseaudio}/bin/paplay \
      "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/complete.oga" \
      >/dev/null 2>&1 || true
  '';
in
{
  home.file.".codex/config.toml" = {
    force = true;
    text = ''
    model = "gpt-5.4"
    model_reasoning_effort = "medium"
    network_access = true
    personality = "pragmatic"
    notify = ["${config.home.homeDirectory}/.local/bin/codex-notify"]

    [features]
    web_search_request = true

    [tui]
    notifications = ["agent-turn-complete", "approval-requested"]
    notification_method = "bel"

    [projects."/home/watanabe/.dotfiles"]
    trust_level = "trusted"

    [projects."/home/watanabe/work/zxing-cpp"]
    trust_level = "trusted"

    [projects."/home/watanabe/work/rust_os/repo/wasabi"]
    trust_level = "trusted"

    [projects."/home/watanabe/ktmp"]
    trust_level = "trusted"

    [projects."/home/watanabe/work/tmp"]
    trust_level = "trusted"

    [notice.model_migrations]
    gpt-5-codex = "gpt-5.2-codex"
    '';
  };

  home.file.".local/bin/codex-notify".source = codexNotify;
}
