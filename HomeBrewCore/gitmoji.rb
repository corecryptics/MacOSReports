require "language/node"

class Gitmoji < Formula
  desc "Interactive command-line tool for using emoji in commit messages"
  homepage "https://gitmoji.dev"
  url "https://registry.npmjs.org/gitmoji-cli/-/gitmoji-cli-6.3.0.tgz"
  sha256 "cdb9980f9e419a08dfc9e8c390cc1d516a4ee33e2976f170a916653b25ed6bc7"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f98046c3f1ed8cffea218cd411b9aae2ef4574440f89571bb0c8f39b5369647d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f98046c3f1ed8cffea218cd411b9aae2ef4574440f89571bb0c8f39b5369647d"
    sha256 cellar: :any_skip_relocation, monterey:       "a0767e7239b93d345d27d0da13238dfea0aad78e5d0ca56adaf9c7856cedd976"
    sha256 cellar: :any_skip_relocation, big_sur:        "a0767e7239b93d345d27d0da13238dfea0aad78e5d0ca56adaf9c7856cedd976"
    sha256 cellar: :any_skip_relocation, catalina:       "a0767e7239b93d345d27d0da13238dfea0aad78e5d0ca56adaf9c7856cedd976"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f98046c3f1ed8cffea218cd411b9aae2ef4574440f89571bb0c8f39b5369647d"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match ":bug:", shell_output("#{bin}/gitmoji --search bug")
  end
end
