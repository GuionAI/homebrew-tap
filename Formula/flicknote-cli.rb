class FlicknoteCli < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7098eb0753d82b997733ff2b80c9132589ffd79ec95413389403bd367db5aabc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3dd5f525bf172804e40051f02bd0cdca2b3e58159c331c1cd821fbab12f417a7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "5f35d39b5de8c5de2f68fbf7008718e6fae5b18b4cf88a3c7a0d4003ef1473fa"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
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
    bin.install "flicknote" if OS.mac? && Hardware::CPU.arm?
    bin.install "flicknote" if OS.mac? && Hardware::CPU.intel?
    bin.install "flicknote" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
