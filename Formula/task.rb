class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.16"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.16/task-3.4.2-guion.16-aarch64-macos.tar.gz"
      sha256 "f9ae71612e5c992ca85a1fb9fe0ce729689e24e203ccab6a2e765d7a56a48b99"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.16/task-3.4.2-guion.16-x86_64-linux.tar.gz"
      sha256 "318bfdb90b0271ea896c5a4fafa836095d17377e084e85f1012c7fd563893bb4"
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
