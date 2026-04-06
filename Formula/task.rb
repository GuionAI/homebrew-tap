class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.3"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.3/task-3.4.2-guion.3-aarch64-macos.tar.gz"
      sha256 "7aeb72ac0b704e7bd151cf2b6f604fcc76e93a70cd2ade210be2cccf556609a6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.3/task-3.4.2-guion.3-x86_64-linux.tar.gz"
      sha256 "b55f291bb193e763ad953edf69ffd9808e1e4c7697b4206763edf90744f975f5"
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
