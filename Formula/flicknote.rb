class Flicknote < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.2.9"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.2.9/flicknote-cli-aarch64-apple-darwin.tar.xz"
    sha256 "9e370a971a3f23839e066571cfe9c0b6dc903268ec8f1d89678859d049889cde"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.2.9/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "6f050414faaa5bc0f44df0f4e40d09def800725c3e43c9f5a6d0bf6204bb8619"
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
