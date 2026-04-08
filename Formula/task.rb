class Task < Formula
  desc "A command-line todo list manager"
  homepage "https://github.com/GuionAI/taskwarrior"
  version "3.4.2-guion.13"
  license "MIT"
  conflicts_with "go-task", because: "both install a 'task' binary"

  on_macos do
    on_arm do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.13/task-3.4.2-guion.13-aarch64-macos.tar.gz"
      sha256 "59626636f0ded4bc56fd9744b7931ada55de88390b2b955c31f1af894287a38b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/GuionAI/taskwarrior/releases/download/v3.4.2-guion.13/task-3.4.2-guion.13-x86_64-linux.tar.gz"
      sha256 "70c2aa366ea6e031da20a53c97690901b547fdfc18743419d65dc9d0709a412f"
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
