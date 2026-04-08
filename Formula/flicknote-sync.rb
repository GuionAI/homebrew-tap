class FlicknoteSync < Formula
  desc "Background sync daemon for FlickNote CLI"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-sync-aarch64-apple-darwin.tar.xz"
      sha256 "ce910605b6505bd12e6ae9b22b72666423ed3c26e9ac566160628453b246488e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-sync-x86_64-apple-darwin.tar.xz"
      sha256 "3dc813180b650e21e1472a736926d5b650f3c895d05026c8cd1ebe3c8c88e0e5"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.5/flicknote-sync-x86_64-unknown-linux-musl.tar.xz"
    sha256 "edd7c27a966c839b94a88201ce1df3a7814153d876f7c4e82edc2e6c4a5a83ee"
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
    bin.install "flicknote-sync" if OS.mac? && Hardware::CPU.arm?
    bin.install "flicknote-sync" if OS.mac? && Hardware::CPU.intel?
    bin.install "flicknote-sync" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
