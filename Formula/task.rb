class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.9"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.9/task-3.4.2-guion.9-aarch64-macos.tar.gz"
      sha256 "b3418c9217a82cd788345e81963e60b3e90fbe359d69787ce2ca71c753a5b53e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.9/task-3.4.2-guion.9-x86_64-linux.tar.gz"
      sha256 "fcbfccb4560d0795abb8a194f3671d2a9caf3e6b701a675ec8c1943a1f10abd9"
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
