class Openfpgaloader < Formula
  desc "Universal utility for programming FPGA"
  homepage "https://github.com/trabucayre/openFPGALoader"
  url "https://github.com/trabucayre/openFPGALoader/archive/v0.9.1.tar.gz"
  sha256 "6520475fb98491aa040f35a19dd688be0729c2b9da81857e6963360e5142d02c"
  license "Apache-2.0"
  head "https://github.com/trabucayre/openFPGALoader.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "e4acec5a1d3896d70813ccc01f5c1283c506537db2fd4c49cd2b1c3590dba450"
    sha256 cellar: :any,                 arm64_big_sur:  "1605fdd27f43f3c6286d04fe945383893789a6508ff3799ec662c968ba574097"
    sha256 cellar: :any,                 monterey:       "fc20318f66b56eea629def75b26d31dd44455518bc2d01edac6a7cab4283cd44"
    sha256 cellar: :any,                 big_sur:        "cab3e8c82802be5e6cef1bf32d7b4de819bbecc1c4241707968efeaff9595a88"
    sha256 cellar: :any,                 catalina:       "a9a01e282a2a577c4c20f0dd6d1266695696b9851285454c4472e701639c2d90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf8627addd17ad6ca20bbad18bd30f9bc59e613acf0ef5a80376d1b7d6ba659c"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libftdi"
  depends_on "libusb"
  uses_from_macos "zlib"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    version_output = shell_output("#{bin}/openFPGALoader -V 2>&1")
    assert_match "openFPGALoader v#{version}", version_output

    error_output = shell_output("#{bin}/openFPGALoader --detect 2>&1 >/dev/null", 1)
    assert_includes error_output, "JTAG init failed"
  end
end
