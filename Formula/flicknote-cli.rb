class FlicknoteCli < Formula
  desc "Local-first note management CLI with cloud sync"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-cli-aarch64-apple-darwin.tar.xz"
      sha256 "0769c6fd1b686506b1c332ee93d451b8380f90d9b8daf37e21e9bfb3af3328bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-cli-x86_64-apple-darwin.tar.xz"
      sha256 "594dff10d73d0a1b281fe092924cf58af2c9748beacbd348babbba27d54971d2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-cli-x86_64-unknown-linux-musl.tar.xz"
    sha256 "9c44ea55a5d3e9c900eb8ec8c7260557016a03bdc3ad6d511dff510ea5fe3ea9"
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
