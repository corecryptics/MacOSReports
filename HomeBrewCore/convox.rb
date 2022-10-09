class Convox < Formula
  desc "Command-line interface for the Convox PaaS"
  homepage "https://convox.com/"
  url "https://github.com/convox/convox/archive/3.5.6.tar.gz"
  sha256 "4713f8a4838c95023915fa371ea6e524e78ef34793d96034b1a702ee99136dcc"
  license "Apache-2.0"
  version_scheme 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7942aae59a794073db02a03d087c60cb25909bc097290d52425759d31e67d3d8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e6b1e2477c950605a2d5e5e28fdc732326524ddd99c966e24c68389c79094b10"
    sha256 cellar: :any_skip_relocation, monterey:       "740b02982e512bcb26763bfe95a2ed3e905f6787990655462d7435c10fe3d863"
    sha256 cellar: :any_skip_relocation, big_sur:        "4d03692a811ca5cc23a341c35356478aa53d883a9f581d7b955744c3670b941d"
    sha256 cellar: :any_skip_relocation, catalina:       "20f6cb28a0da76431c137b409c2797934a751e2ebe0a0e5b27f2bafafd686205"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a956c0dc7b0cb701ae30d90f5f55dbb0fa50e8751900b9d39da9648249e710c"
  end

  depends_on "go" => :build

  # Support go 1.17, remove when upstream patch is merged/released
  # https://github.com/convox/convox/pull/389
  patch do
    url "https://github.com/convox/convox/commit/d28b01c5797cc8697820c890e469eb715b1d2e2e.patch?full_index=1"
    sha256 "a0f94053a5549bf676c13cea877a33b3680b6116d54918d1fcfb7f3d2941f58b"
  end

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]

    system "go", "build", "-mod=readonly", *std_go_args(ldflags: ldflags), "./cmd/convox"
  end

  test do
    assert_equal "Authenticating with localhost... ERROR: invalid login\n",
      shell_output("#{bin}/convox login -t invalid localhost 2>&1", 1)
  end
end
