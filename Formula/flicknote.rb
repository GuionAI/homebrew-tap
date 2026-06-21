class Flicknote < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.2.7"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.2.7/flicknote-cli-aarch64-apple-darwin.tar.xz"
    sha256 "4ef44e9974873987dc02e085044afc3503e4750bafd4c57c81579673f3eb7c07"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.2.7/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "b0c88f63e586e38777c2329fe5ef8e0e59104b9385b07bac9402ba92fd07cccb"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "flicknote", "flicknote-sync" if OS.mac? && Hardware::CPU.arm?
    bin.install "flicknote", "flicknote-sync" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
