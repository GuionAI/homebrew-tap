class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.10"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.10/task-3.4.2-guion.10-aarch64-macos.tar.gz"
      sha256 "eda77b645f6c948834e18f5085c444e2421c433debe742e6c5fc4c610b12d577"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.10/task-3.4.2-guion.10-x86_64-linux.tar.gz"
      sha256 "7135027ffcd973758a469931a58593ce2216fb7925366294e392faed67d4f3d3"
    end
  end

  def install
    bin.install "task"
    bash_completion.install "completions/task.sh"
    zsh_completion.install "completions/_task"
    fish_completion.install "completions/task.fish"
  end

  test do
    system bin/"task", "--version"
  end
end
