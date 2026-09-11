class Flicknote < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "1.4.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/guionai/flicknote-cli/releases/download/v1.4.0/flicknote-cli-aarch64-apple-darwin.tar.xz"
    sha256 "b6ad976655c457cffc19cd94a5e0bed6b9f1c42510b62d29452d81ea9f47e1cb"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v1.4.0/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "0de5e8bed8fa2ca046788355d10de703dfd52617503fb9d457dcfb898d0e6991"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "flicknote"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "flicknote"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
