class Stillwright < Formula
  desc "State keeper (sw) for the Stillwright agent skills: goals, runs, inbox, dated notes, hash-pinned tools"
  homepage "https://github.com/HamzaIlyas/stillwright"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.0/stillwright-aarch64-apple-darwin.tar.xz"
      sha256 "da142094c351ebe35802223e36ce00018b0224a8efd9d73689ca01c3e98bea51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.0/stillwright-x86_64-apple-darwin.tar.xz"
      sha256 "d99b18aa51e1ee90d8d5146b60d331ed56e8107b835a94ea6cd65c528dd40ab7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.0/stillwright-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c73af7b8e1cf91ccfc3c866668ef1f26bd642300968afd34829bc8a4767603b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HamzaIlyas/stillwright/releases/download/v0.2.0/stillwright-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93a2a32e9c9f5aa24b25dec5f1888d017fbfcd8a4fdb506d3c9a634b21b648db"
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
