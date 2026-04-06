class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.4"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.4/task-3.4.2-guion.4-aarch64-macos.tar.gz"
      sha256 "f098cc76a22af7514402927f846882ee89951c177a927dced750e2cfb72d5b49"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.4/task-3.4.2-guion.4-x86_64-linux.tar.gz"
      sha256 "9a3cb4f087c25c371c4e84ac58118ee7ea6ea1bec3cb0e13f0eae191dc96faaa"
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
