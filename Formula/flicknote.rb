class Flicknote < Formula
  desc "Local-first note and task management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  license "MIT"
  version "0.1.2"

  on_macos do
    on_arm do
      url "https://releases.flicknote.app/flicknote-cli/v0.1.2/flicknote_v0.1.2_Darwin_arm64.tar.gz"
      sha256 "d0ec604d6d8dc77ffb5ee315a84b29e39dda7b0a0e6d2e4b25132fb67a95f059"
    end
    on_intel do
      url "https://releases.flicknote.app/flicknote-cli/v0.1.2/flicknote_v0.1.2_Darwin_x86_64.tar.gz"
      sha256 "358122ac14b15d27bdc2a1389b5717aa9a7b015ea58902477f36929a615044be"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.flicknote.app/flicknote-cli/v0.1.2/flicknote_v0.1.2_Linux_x86_64.tar.gz"
      sha256 "2d9bf4ad63390f7c4820e544189a1a67cedbccd74f53ebdea67d16d8900c2834"
    end
  end

  def install
    bin.install "flicknote"
    bin.install "flicktask"
    bin.install "flicknote-sync"
  end

  test do
    assert_match "flicknote", shell_output("#{bin}/flicknote --help")
    assert_match "flicktask", shell_output("#{bin}/flicktask list --help")
  end
end
