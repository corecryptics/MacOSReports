class DosboxX < Formula
  desc "DOSBox with accurate emulation and wide testing"
  homepage "https://dosbox-x.com/"
  url "https://github.com/joncampbell123/dosbox-x/archive/dosbox-x-v0.84.0.tar.gz"
  sha256 "564fbf8f0ab090c8b32bc38637c8204358c386b9cbffcb4f99a81bc82fddbad7"
  license "GPL-2.0-or-later"
  version_scheme 1
  head "https://github.com/joncampbell123/dosbox-x.git", branch: "master"

  livecheck do
    url :stable
    regex(/^dosbox-x[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_monterey: "954854b0a822a53dfa548e6b8ac8ccd38683bd49393b5b7daa07725934912c9c"
    sha256 cellar: :any, arm64_big_sur:  "9eb877ad9475ab9ae064f2900fc70ba3155871791e7a207a830c9e0696c716ce"
    sha256 cellar: :any, monterey:       "7f12623698d54585f85f6a2a3d72670f42de50e8bf69c9a095b831b43b00674b"
    sha256 cellar: :any, big_sur:        "d8e790814fefd140a3dd9e7f16b4efe6e2f7dbafbf53e2071281e5cb3218f7d9"
    sha256 cellar: :any, catalina:       "35036fdd6ec98ee64e45df685d299ea257089e03687583cb68b168b91880ccf5"
    sha256               x86_64_linux:   "20d381a2330a34deefd3f31feb369f9859d0630dc16d9ce78d8743114b646951"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "fluid-synth"
  depends_on macos: :high_sierra # needs futimens

  on_linux do
    depends_on "linux-headers@5.15" => :build
    depends_on "sdl2"
  end

  fails_with gcc: "5"

  def install
    ENV.cxx11

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-sdltest
    ]
    build_script = OS.mac? ? "./build-macosx" : "./build"
    system build_script, *args
    system "make", "install"
  end

  test do
    assert_match "DOSBox-X version #{version}", shell_output("#{bin}/dosbox-x -version 2>&1", 1)
  end
end
