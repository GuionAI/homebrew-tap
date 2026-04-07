class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.11"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.11/task-3.4.2-guion.11-aarch64-macos.tar.gz"
      sha256 "0ddc2c8c5b5a3c5f88464504dfcc9515f772d832834a2fc57261ae507d99c42b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.11/task-3.4.2-guion.11-x86_64-linux.tar.gz"
      sha256 "d377963e301283e7486b4a7851654f22d897f00b7b1ecb1cb0fe5081262bc990"
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
