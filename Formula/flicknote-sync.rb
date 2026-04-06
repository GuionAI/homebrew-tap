class FlicknoteSync < Formula
  desc "Background sync daemon for FlickNote CLI"
  homepage "https://github.com/guionai/flicknote-cli"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.3/flicknote-sync-aarch64-apple-darwin.tar.xz"
      sha256 "bd0aae5f7cccbb9048536b4b2863349a30ea3a77e3a06a9962446c6d8189e1e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.3/flicknote-sync-x86_64-apple-darwin.tar.xz"
      sha256 "888020d43e4360af99af71dd9db3ddb920dfc500a14664ecca8b706dc2209473"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/guionai/flicknote-cli/releases/download/v0.1.3/flicknote-sync-x86_64-unknown-linux-musl.tar.xz"
    sha256 "67f79062129877465d569390149a052688e540f0f591e5b4b5353f2fcae959d1"
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
