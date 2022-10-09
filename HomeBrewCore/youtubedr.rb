class Youtubedr < Formula
  desc "Download Youtube Video in Golang"
  homepage "https://github.com/kkdai/youtube"
  url "https://github.com/kkdai/youtube/archive/v2.7.16.tar.gz"
  sha256 "3ef4c2580eb8d95eb23555757c07a85e0e8281edf12b546722e59b5ca5348d6d"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "61c7039357001bb60e5631ae90b756a4efa519588721c86cb4d91d84026143a3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "61c7039357001bb60e5631ae90b756a4efa519588721c86cb4d91d84026143a3"
    sha256 cellar: :any_skip_relocation, monterey:       "7108b18e5756e30d3e344045c21a2f46c71bd5494a194f3352939694b905dc2c"
    sha256 cellar: :any_skip_relocation, big_sur:        "7108b18e5756e30d3e344045c21a2f46c71bd5494a194f3352939694b905dc2c"
    sha256 cellar: :any_skip_relocation, catalina:       "7108b18e5756e30d3e344045c21a2f46c71bd5494a194f3352939694b905dc2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "797642c22eab8c871ad1068b66ef688b3abf72a29db3d1edaf809cee33e66321"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.date=#{time.iso8601}
    ].join(" ")

    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/youtubedr"
  end

  test do
    version_output = pipe_output("#{bin}/youtubedr version").split("\n")
    assert_match(/Version:\s+#{version}/, version_output[0])

    info_output = pipe_output("#{bin}/youtubedr info https://www.youtube.com/watch\?v\=pOtd1cbOP7k").split("\n")
    assert_match "Title:       History of homebrew-core", info_output[0]
    assert_match "Author:      Rui Chen", info_output[1]
    assert_match "Duration:    13m15s", info_output[2]
  end
end
