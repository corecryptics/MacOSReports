class DosboxStaging < Formula
  desc "Modernized DOSBox soft-fork"
  homepage "https://dosbox-staging.github.io/"
  url "https://github.com/dosbox-staging/dosbox-staging/archive/v0.78.1.tar.gz"
  sha256 "dcd93ce27f5f3f31e7022288f7cbbc1f1f6eb7cc7150c2c085eeff8ba76c3690"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/dosbox-staging/dosbox-staging.git", branch: "main"

  # New releases of dosbox-staging are indicated by a GitHub release (and
  # an announcement on the homepage), not just a new version tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_monterey: "aee8f83dc640a97a4b757386dd049f06be41c471688be8720f50f224edf6edf7"
    sha256 cellar: :any, arm64_big_sur:  "3e20ac7db17e1c1cfa454ab71754d5b813bfa7d25b2a109aeef01cbbda2263b1"
    sha256 cellar: :any, monterey:       "c5eed54e549f66e2781609bee5dbe2216dc2cea88eef2d7df44b78bc711a5e3c"
    sha256 cellar: :any, big_sur:        "86bfd2c8677f542c8046e80ef60110d24b32ec24f84f6a4779a2f44c031e0dad"
    sha256 cellar: :any, catalina:       "a616bc8157efa84c5bf4f75bdce6c6717df3fd0349e3e1950906e44a867a88ad"
    sha256               x86_64_linux:   "508eb77dd99c36837cfa25fd10cdc078b5b551546eed5d356018ebfa53e67b7e"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "fluid-synth"
  depends_on "libpng"
  depends_on "libslirp"
  depends_on "mt32emu"
  depends_on "opusfile"
  depends_on "sdl2"
  depends_on "sdl2_net"

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  fails_with gcc: "5"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Db_lto=true", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
    mv bin/"dosbox", bin/"dosbox-staging"
    mv man1/"dosbox.1", man1/"dosbox-staging.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dosbox-staging -version")
    config_path = OS.mac? ? "Library/Preferences/DOSBox" : ".config/dosbox"
    mkdir testpath/config_path
    touch testpath/config_path/"dosbox-staging.conf"
    output = shell_output("#{bin}/dosbox-staging -printconf")
    assert_equal testpath/config_path/"dosbox-staging.conf", Pathname(output.chomp)
  end
end
