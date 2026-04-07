class FlicknoteSync < Formula
  desc "Background sync daemon for FlickNote CLI"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-sync-aarch64-apple-darwin.tar.xz"
      sha256 "40d5f4e8c5d88c5d896b46f97e0ca6ff14257dd79a6508dce35aab0ed826e798"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-sync-x86_64-apple-darwin.tar.xz"
      sha256 "007a3ca8d11fa2b4e4f0a89ceb5db7ac499a57d3d3f3081fd9e0bbffb867c420"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.4/flicknote-sync-x86_64-unknown-linux-musl.tar.xz"
    sha256 "10ecb143c3bd806d1bedc62f8e985a6a5cdc721a9316e9db67c9d59f241c81ef"
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
