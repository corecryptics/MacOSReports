class Qcachegrind < Formula
  desc "Visualize data generated by Cachegrind and Calltree"
  homepage "https://kcachegrind.github.io/"
  url "https://download.kde.org/stable/release-service/22.08.1/src/kcachegrind-22.08.1.tar.xz"
  sha256 "1a924a5b2d8f7838c37629a34d9725011c0afcc417d8a7ae83ae39a0b1b38c17"
  license "GPL-2.0-or-later"

  # We don't match versions like 19.07.80 or 19.07.90 where the patch number
  # is 80+ (beta) or 90+ (RC), as these aren't stable releases.
  livecheck do
    url "https://download.kde.org/stable/release-service/"
    regex(%r{href=.*?v?(\d+\.\d+\.(?:(?![89]\d)\d+)(?:\.\d+)*)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "ff083c9c111c24d44fe0da28a871c0828230ac8400c03698239d48f30865e227"
    sha256 cellar: :any,                 arm64_big_sur:  "2abf17beaf89572fc8aeb1571fb42a45185db500abb152c68fe2b46aa40ecb47"
    sha256 cellar: :any,                 monterey:       "a069d24d44ecb72642fd0ac447a84e1aef27e31519abfc29fdafab2181c5d410"
    sha256 cellar: :any,                 big_sur:        "cfbbf20db90ae10b02459bc29194d6e8fe38217b0cc5ca75d4b6ecd5b4b3d686"
    sha256 cellar: :any,                 catalina:       "c2c61b5ad35ebfda3a8e97fdbf6b6e436540220e22c9f8315ec2e2db800fd6c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f811e78bdf4d8d4c1ea93541d9b2f0e4863d87d150cc653a5d7a04f307e4f90d"
  end

  depends_on "graphviz"
  depends_on "qt@5"

  fails_with gcc: "5"

  def install
    args = ["-config", "release", "-spec"]
    os = OS.mac? ? "macx" : OS.kernel_name.downcase
    compiler = ENV.compiler.to_s.start_with?("gcc") ? "g++" : ENV.compiler
    arch = Hardware::CPU.intel? ? "" : "-#{Hardware::CPU.arch}"
    args << "#{os}-#{compiler}#{arch}"

    system Formula["qt@5"].opt_bin/"qmake", *args
    system "make"

    if OS.mac?
      prefix.install "qcachegrind/qcachegrind.app"
      bin.install_symlink prefix/"qcachegrind.app/Contents/MacOS/qcachegrind"
    else
      bin.install "qcachegrind/qcachegrind"
    end
  end
end
