class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.8"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.8/task-3.4.2-guion.8-aarch64-macos.tar.gz"
      sha256 "f9380fa5f6b33416efb729595f18da88590eabdb9663820e52771d0d1fa29a1b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.8/task-3.4.2-guion.8-x86_64-linux.tar.gz"
      sha256 "e2e2caef5ccbbf52af850890c716789acd53f01f19b3e241ce3250739f2a4472"
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
