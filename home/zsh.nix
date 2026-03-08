{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      zcompdump_path=''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
      mkdir -p "''${zcompdump_path:h}"
      if [[ -s "$zcompdump_path" ]]; then
        autoload -U compinit && compinit -C -d "$zcompdump_path"
      else
        autoload -U compinit && compinit -d "$zcompdump_path"
      fi
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    siteFunctions = {
      fzf-select-history = ''
        BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
        CURSOR=$#BUFFER
        zle reset-prompt
      '';

    };
    initExtraBeforeCompInit = ''
      if [ -n "$ZSH_PROFILE" ]; then
        zmodload zsh/zprof
      fi
    '';
    initContent = ''
      # --------------------------------------------------
      # fzf history 🚀
      # --------------------------------------------------
      fzf_select_history() {
        # --height 40% で画面下40%に表示
        # --reverse で入力を下に、候補をその上に表示
        # --border で境界線を追加
        BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse --height 40% --border)
        CURSOR=$#BUFFER
        zle reset-prompt
      }
      zle -N fzf_select_history
      bindkey '^r' fzf_select_history

      # --------------------------------------------------
      # Zsh Completion Styling 🎨
      # --------------------------------------------------
      # 補完候補に色を付ける
      zstyle ':completion:*' list-colors 'di=1;34:ln=1;35:ex=1;31'

      if [ -n "$ZSH_PROFILE" ]; then
        zprof
      fi
    '';

    shellAliases = {
      ls = "eza --icons=auto --git --git-repos --group-directories-first --sort=name --time-style=long-iso -hi --hyperlink -F always";
      edit = "sudo -e";
      update = "cd ~/.dotfiles/ && git add . && sudo nixos-rebuild switch --flake .#nixos && cd -";
      upgrade = "cd ~/.dotfiles/ && git add . && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos && cd -";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];
  };
}
