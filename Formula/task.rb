class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.0.2-guion.39"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.0.2-guion.39/task-3.0.2-guion.39-aarch64-macos.tar.gz"
      sha256 "339a8802c05280cb66c830e756aa1d0d5df20c1c8f48627d4f1c08d3e88a4d3d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.0.2-guion.39/task-3.0.2-guion.39-x86_64-linux.tar.gz"
      sha256 "5b0ff5e7ff70e3a97d220a83305f8c17341ffb8d0ecbcca14c2287a8d8d503eb"
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
