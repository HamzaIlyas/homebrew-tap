class Stillwright < Formula
  desc "State keeper (sw) for the Stillwright agent skills: goals, runs, inbox, dated notes, hash-pinned tools"
  homepage "https://github.com/HamzaIlyas/stillwright"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.1/stillwright-aarch64-apple-darwin.tar.xz"
      sha256 "55e0505a123d1f1b20b748c515b7d34db5263a57e2ec54bc2f15dc381fb1d1ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.1/stillwright-x86_64-apple-darwin.tar.xz"
      sha256 "a8bef67a64cacf60f4b977519590760859871c80aac860c8e1638c4cc6d0f68c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.1/stillwright-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91e6db85ad263ebb4f4b33109b016a6fa26ec9b9afab0e384399285a2b40f991"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.1/stillwright-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a57d0e8d86feb4b75316f86ca834eda1f22fb84000b92cc3cf38cf2c12126cec"
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
