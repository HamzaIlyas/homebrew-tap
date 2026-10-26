class Stillwright < Formula
  desc "State keeper (sw) for the Stillwright agent skills: goals, runs, inbox, dated notes, hash-pinned tools"
  homepage "https://github.com/HamzaIlyas/stillwright"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.1.5/stillwright-aarch64-apple-darwin.tar.xz"
      sha256 "b878ed7032a409e83dfdbaf8d7c465a2848c24f200d45ca7ab85dadd6d976b68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.1.5/stillwright-x86_64-apple-darwin.tar.xz"
      sha256 "821b51f2227084940066d69c1aa6542c92aa229e8585389c93e7a88cedb7e1f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.1.5/stillwright-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a2449fc5f50049b6931f68068833e87dfa4f8dd168facbb4e4973812d61f9c6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.1.5/stillwright-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d12a5336d20d284a1f0401e53ee6bbeb777eb7550097d268af7d40b882f59db3"
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
