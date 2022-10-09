class Felinks < Formula
  desc "Text mode browser and Gemini, NNTP, FTP, Gopher, Finger, and BitTorrent client"
  homepage "https://github.com/rkd77/elinks#readme"
  url "https://github.com/rkd77/elinks/archive/refs/tags/v0.15.1.tar.gz"
  sha256 "a3ebb14e179fcf97f93874b7771b4b05c1b7fdc704807334e865273d9de8428f"
  license "GPL-2.0-only"
  head "https://github.com/rkd77/elinks.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "62fb5bbd61d30658befb6916bbb5af4699fb2777286746dcaa94e9828abd2d2c"
    sha256 cellar: :any,                 arm64_big_sur:  "1576662f71a70f08b3bb2b74fa32b8315a9f7a0012979457c805ae01daa770e9"
    sha256 cellar: :any,                 monterey:       "9c4d8fa6827abd2147a9b20fe30de764acd9a05c6496ac3d751d94041151d39c"
    sha256 cellar: :any,                 big_sur:        "7e382952edc473bcfd458d9bbce990acd5120588d62af6d3f37c5db55c9785d2"
    sha256 cellar: :any,                 catalina:       "6338231bbe0e52aaa943e88aa437876604bc45c726b37e91769450b9808c8e43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c130f71e181e3a807ad0e1951b2b0f97301f7107829d21fb3817d263f918c977"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "groff" => :build
  depends_on "libtool" => :build
  depends_on "xmlto" => :build

  depends_on "brotli"
  depends_on "libidn"
  depends_on "openssl@1.1"
  depends_on "tre"
  depends_on "zstd"

  uses_from_macos "bison"
  uses_from_macos "bzip2"
  uses_from_macos "expat"
  uses_from_macos "zlib"

  conflicts_with "elinks", because: "both install the same binaries"

  def install
    # https://github.com/rkd77/elinks/issues/47#issuecomment-1190547847 parallelization issue.
    ENV.deparallelize
    system "./autogen.sh"
    system "./configure", *std_configure_args,
                          "--disable-nls",
                          "--enable-256-colors",
                          "--enable-88-colors",
                          "--enable-bittorrent",
                          "--enable-cgi",
                          "--enable-exmode",
                          "--enable-finger",
                          "--enable-gemini",
                          "--enable-gopher",
                          "--enable-html-highlight",
                          "--enable-nntp",
                          "--enable-true-color",
                          "--with-brotli",
                          "--with-openssl",
                          "--with-tre",
                          "--without-gnutls",
                          "--without-perl",
                          "--without-spidermonkey",
                          "--without-xterm"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.html").write <<~EOS
      <!DOCTYPE html>
      <title>Hello World!</title>
      Abracadabra
    EOS
    assert_match "Abracadabra",
      shell_output("#{bin}/elinks -dump test.html").chomp
  end
end
