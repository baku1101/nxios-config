{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    siteFunctions = {
      fzf-select-history = ''
        BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
        CURSOR=$#BUFFER
        zle reset-prompt
      '';

    };
    initExtra = ''
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
      # 補完機能を有効化
      autoload -U compinit && compinit
      # 補完候補に色を付ける
      zstyle ':completion:*' list-colors 'di=1;34:ln=1;35:ex=1;31'
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        {
          name = "mafredri/zsh-async";
          tags = [
            "from:github"
            "use:async.zsh"
          ];
        }
        {
          name = "hlissner/zsh-autopair";
          tags = [ "defer:2" ];
        }
      ];
    };

    shellAliases = {
      ls = "eza --icons=auto --git --git-repos --group-directories-first --sort=name --time-style=long-iso -hi --hyperlink -F always";
      edit = "sudo -e";
      update = "cd ~/.dotfiles/ && git add . && sudo nixos-rebuild switch --flake .#nixos && cd -";
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
