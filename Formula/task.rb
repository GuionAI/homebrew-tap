class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.17"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.17/task-3.4.2-guion.17-aarch64-macos.tar.gz"
      sha256 "15fd27871bd1c36e1f4a08006dfe9930290c72ed6fa7a5596a31058220f7d661"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.17/task-3.4.2-guion.17-x86_64-linux.tar.gz"
      sha256 "5b22aac2dcb0ada34ebd85ad22cbb3d2632565f8b708643ae27a1c4c49134dd9"
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
