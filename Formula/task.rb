class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.7"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.7/task-3.4.2-guion.7-aarch64-macos.tar.gz"
      sha256 "ab49ca47b2a988de56cbb236f3f01d3784ab23688fd246a8cd5dd13cdddfe7a7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.7/task-3.4.2-guion.7-x86_64-linux.tar.gz"
      sha256 "0cbc7b9a868eb7aa764e4aa21e7141cb7e576b8674f84d7c302debf0de99d109"
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
