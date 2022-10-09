class Enzyme < Formula
  desc "High-performance automatic differentiation of LLVM"
  homepage "https://enzyme.mit.edu"
  url "https://github.com/EnzymeAD/Enzyme/archive/v0.0.37.tar.gz", using: :homebrew_curl
  sha256 "9648c67351e27c5f568baa338c15bf6197374f425a4c99654bbd2c25b25e24e8"
  license "Apache-2.0" => { with: "LLVM-exception" }
  revision 1
  head "https://github.com/EnzymeAD/Enzyme.git", branch: "main"

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "7179eb37f45c8002d4c48e7392160ca9764a87e1c0ef442b7c8fd784c008e62f"
    sha256 cellar: :any,                 arm64_big_sur:  "b2d2416e07a6fb28a820767a481685ce4cb7579c50a96f325385cd24480275b9"
    sha256 cellar: :any,                 monterey:       "37e9e8775c885094f5e38f9140cc65cdd6fb6d1e8a48ef8fc3265c9db7d40d05"
    sha256 cellar: :any,                 big_sur:        "feb20a460780e989f83030aa1eb0a9c5ecdbaaa67b24d4c5ac7ace702c86fead"
    sha256 cellar: :any,                 catalina:       "ff00e1ce094a81c636f5d980f8430a2e9854f636949f192aa9f6d141b6870446"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "320d4ec5da135e5c44734779d3619a254581061af7386964cd1e0968b5ceafb5"
  end

  depends_on "cmake" => :build
  depends_on "llvm@14"

  fails_with gcc: "5"

  def llvm
    deps.map(&:to_formula).find { |f| f.name.match? "^llvm" }
  end

  def install
    system "cmake", "-S", "enzyme", "-B", "build", *std_cmake_args, "-DLLVM_DIR=#{llvm.opt_lib}/cmake/llvm"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      extern double __enzyme_autodiff(void*, double);
      double square(double x) {
        return x * x;
      }
      double dsquare(double x) {
        return __enzyme_autodiff(square, x);
      }
      int main() {
        double i = 21.0;
        printf("square(%.0f)=%.0f, dsquare(%.0f)=%.0f\\n", i, square(i), i, dsquare(i));
      }
    EOS

    opt = llvm.opt_bin/"opt"
    ENV["CC"] = llvm.opt_bin/"clang"

    system ENV.cc, testpath/"test.c", "-S", "-emit-llvm", "-o", "input.ll", "-O2",
                   "-fno-vectorize", "-fno-slp-vectorize", "-fno-unroll-loops"
    system opt, "input.ll", "--enable-new-pm=0",
                "-load=#{opt_lib/shared_library("LLVMEnzyme-#{llvm.version.major}")}",
                "--enzyme-attributor=0", "-enzyme", "-o", "output.ll", "-S"
    system ENV.cc, "output.ll", "-O3", "-o", "test"

    assert_equal "square(21)=441, dsquare(21)=42\n", shell_output("./test")
  end
end
