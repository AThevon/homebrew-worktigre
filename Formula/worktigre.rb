# typed: false
# frozen_string_literal: true

class Worktigre < Formula
  desc "Git worktree manager with fzf integration and GitHub/GitLab support"
  homepage "https://github.com/AThevon/worktigre"
  url "https://github.com/AThevon/worktigre/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "76c7f4aac74ac9a614475388f509a94fe2eb9bba260c8f35bd8248418ffa39ac"
  license "GPL-3.0-or-later"

  # Allow existing users who installed `wt` to migrate on `brew upgrade`
  oldname "wt"

  depends_on "fzf"
  depends_on "gh"
  depends_on "glab"
  depends_on "gum"
  depends_on "jq"

  def install
    bin.install "wt.sh" => "wt-core"
    (prefix/"lib/worktigre").install Dir["lib/*.sh"]
    (prefix/"assets/worktigre").install Dir["assets/logo*.ansi"]
    zsh_completion.install "completions/wt.zsh" => "_wt"
  end

  def caveats
    <<~EOS
      To enable automatic directory changing, add to your .zshrc:

        eval "$(wt-core --shell-init)"

      Then restart your terminal or run: source ~/.zshrc
    EOS
  end

  test do
    assert_match "wt 2.3.0", shell_output("#{bin}/wt-core --version 2>&1")
  end
end
