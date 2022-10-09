class Sourcekitten < Formula
  desc "Framework and command-line tool for interacting with SourceKit"
  homepage "https://github.com/jpsim/SourceKitten"
  url "https://github.com/jpsim/SourceKitten.git",
      tag:      "0.33.0",
      revision: "b5f9bb749057dd396e93f97956bef64672bc2a04"
  license "MIT"
  head "https://github.com/jpsim/SourceKitten.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2a86efc5b38dd19589812df8835fe060b67416a1452dfd54fa030f9b42e92959"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bc94480ea441f3effc6f2f4137d74f1548f95fc8650f2ce58d0dae16baee3760"
    sha256 cellar: :any_skip_relocation, monterey:       "c1d8fc2ab846cb417aeece001a6f177b363c2109fb411cc312f54b32245fc974"
    sha256 cellar: :any_skip_relocation, big_sur:        "7a3e6807a9f3625cf0a887cbbd9a7f3380960393aeadf698798144a373757ba8"
  end

  depends_on xcode: ["13.0", :build]
  depends_on :macos
  depends_on xcode: "6.0"

  def install
    system "make", "prefix_install", "PREFIX=#{prefix}", "TEMPORARY_FOLDER=#{buildpath}/SourceKitten.dst"
  end

  test do
    system "#{bin}/sourcekitten", "version"
    return if MacOS::Xcode.version < 13

    ENV["IN_PROCESS_SOURCEKIT"] = "YES"
    system "#{bin}/sourcekitten", "syntax", "--text", "import Foundation // Hello World"
  end
end
