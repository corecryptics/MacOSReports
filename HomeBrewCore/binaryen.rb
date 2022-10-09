class Binaryen < Formula
  desc "Compiler infrastructure and toolchain library for WebAssembly"
  homepage "https://webassembly.org/"
  url "https://github.com/WebAssembly/binaryen/archive/version_110.tar.gz"
  sha256 "0f80250a02b94dd81bdedeae029eb805abf607fcdadcfee5ca8b5e6b77035601"
  license "Apache-2.0"
  head "https://github.com/WebAssembly/binaryen.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "40a5a0d8afbdbcb26fd52ea0a66804ff52860f8a4054ea285dd337272438ecf3"
    sha256 cellar: :any,                 arm64_big_sur:  "7f1193147c44db434a09fa887a9f231307d1bd3e2fe8eb8dad5b9012f268a2e5"
    sha256 cellar: :any,                 monterey:       "41150cf0ab34367f6e20a075cb4308a8e9223294c047f4177df95b03bca5e249"
    sha256 cellar: :any,                 big_sur:        "b53db2c1d71c0b70d10bcd10805a70c55786fe9765fe331ca96d24e4a1cbbfc1"
    sha256 cellar: :any,                 catalina:       "d879dcf03cbb1e077987af97baa0be57f7965e0e308a4bd07e7117855d2d2eb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "332e17b0b3ada2bf14b79c1a8fba7e3c42f9622db6393f94252b7ccdccaf0ddd"
  end

  depends_on "cmake" => :build
  depends_on "python@3.10" => :build

  fails_with gcc: "5"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_TESTS=false"
    system "make", "install"

    pkgshare.install "test/"
  end

  test do
    system "#{bin}/wasm-opt", "-O", "#{pkgshare}/test/passes/O1_print-stack-ir.wast", "-o", "1.wast"
    assert_match "stacky-help", File.read("1.wast")
  end
end
