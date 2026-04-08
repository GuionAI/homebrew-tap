class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.12"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.12/task-3.4.2-guion.12-aarch64-macos.tar.gz"
      sha256 "6c7e4a485810e5dd8237a0a046d96f7d77add8f001d107c85d7604a14b28263a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.12/task-3.4.2-guion.12-x86_64-linux.tar.gz"
      sha256 "4bd1f7f9caf1bf0d40c9fe98f877f0b5f5ea1476c4ecba19f9634f9bcade5993"
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
