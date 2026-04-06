class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.2"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.2/task-3.4.2-guion.2-aarch64-macos.tar.gz"
      sha256 "84a57fc0b2a740d40d6a5ffa868e10f9ef48734e04921912996e898ccbd81c5b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.2/task-3.4.2-guion.2-x86_64-linux.tar.gz"
      sha256 "a762559bcad1ed3213540e42f80208b5ff69618aba2df331ec2fbd57119683f8"
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
