class Stillwright < Formula
  desc "State keeper (sw) for the Stillwright agent skills: goals, runs, inbox, dated notes, hash-pinned tools"
  homepage "https://github.com/HamzaIlyas/stillwright"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.2/stillwright-aarch64-apple-darwin.tar.xz"
      sha256 "674a26c99e5649f6c194f7b0d2ca83ea8f163629029f5a4e7f2c0273909ba6c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.2/stillwright-x86_64-apple-darwin.tar.xz"
      sha256 "4d09178e37ccec9e239e9126ab8c5a1230797f81fcb2b60fa1b767697910f3a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.2/stillwright-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1206c50096840cc3bab08f0876f0c9729fd466df6f78f38e1cd7d01a9e881b95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.2/stillwright-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "16e3961a5cfcd89f62c22848c8761f5c6964969aa8c27c3ab9110de93a1b1b04"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "sw"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sw"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sw"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sw"
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
