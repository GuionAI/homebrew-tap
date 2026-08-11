class Flicknote < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.5.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.5.1/flicknote-cli-aarch64-apple-darwin.tar.xz"
    sha256 "28c925166a4e7f6853923b8c7af35f2906151555fbf6977024ec5f7f6995dd79"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.5.1/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "66e365e31d0b661770541b7b07f5dbcf901ed3a62d49681dee72f2495e6b2518"
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
      bin.install "flicknote", "flicknote-sync"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "flicknote", "flicknote-sync"
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
