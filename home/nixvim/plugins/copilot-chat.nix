{
  plugins.copilot-chat.enable = true;
  plugins.copilot-chat.settings = {
    answer_header = "## Copilot ";
    auto_follow_cursor = false;
    error_header = "## Error ";
    mappings = {
      close = {
        insert = "<C-c>";
        normal = "q";
      };
      complete = {
        detail = "Use @<Tab> or /<Tab> for options.";
        insert = "<Tab>";
      };
    };
    context = "buffers";
    prompts = {
      Explain = "このコードの説明をしてください。";
      Fix = "このコードの問題を修正してください。";
      Review = "以下のコードをレビューし、改善点を提案してください。";
      Tests = "以下のコードの動作を説明し、ユニットテストを生成してください。";
    };
    question_header = "## User ";
    show_help = false;
    model = "claude-sonnet-4";
    temperature = 0.3;
  };
}
