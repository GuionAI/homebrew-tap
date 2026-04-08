class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.14"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.14/task-3.4.2-guion.14-aarch64-macos.tar.gz"
      sha256 "1c14515fbc06022c09748ef21003d70bbc26aecd0718eea8b4bc4b60d09535c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.14/task-3.4.2-guion.14-x86_64-linux.tar.gz"
      sha256 "ad09624a811291e001b1e4101c5e3ac128e633b405f8845f22b1c9aa1a53f0a7"
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
