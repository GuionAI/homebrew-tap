class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.15"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.15/task-3.4.2-guion.15-aarch64-macos.tar.gz"
      sha256 "fe979ac0c4e642c3be4abc5b2151e6d40fb9b23b60172abeb40274b343cb2010"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.15/task-3.4.2-guion.15-x86_64-linux.tar.gz"
      sha256 "6408c31133e9c7cd04f1acbf50214513fdf85b2d5b4e865686f6b4f8293f8bd8"
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
