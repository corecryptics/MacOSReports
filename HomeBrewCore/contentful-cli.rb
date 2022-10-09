require "language/node"

class ContentfulCli < Formula
  desc "Contentful command-line tools"
  homepage "https://github.com/contentful/contentful-cli"
  url "https://registry.npmjs.org/contentful-cli/-/contentful-cli-1.15.15.tgz"
  sha256 "d51eb84fe670e576be8799c7ec9e848587cd56a6a84e60ac38787f19bdbc3f90"
  license "MIT"
  head "https://github.com/contentful/contentful-cli.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c9aa253e97f13ad0adc065e67b83714f14face3a250d5362e2b862f05bba5e23"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c9aa253e97f13ad0adc065e67b83714f14face3a250d5362e2b862f05bba5e23"
    sha256 cellar: :any_skip_relocation, monterey:       "a2e4ca6a4d3de74102051ead7657dfce7f89e418836550832a6c6a5d41418832"
    sha256 cellar: :any_skip_relocation, big_sur:        "a2e4ca6a4d3de74102051ead7657dfce7f89e418836550832a6c6a5d41418832"
    sha256 cellar: :any_skip_relocation, catalina:       "a2e4ca6a4d3de74102051ead7657dfce7f89e418836550832a6c6a5d41418832"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9aa253e97f13ad0adc065e67b83714f14face3a250d5362e2b862f05bba5e23"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/contentful space list 2>&1", 1)
    assert_match "🚨  Error: You have to be logged in to do this.", output
    assert_match "You can log in via contentful login", output
    assert_match "Or provide a management token via --management-token argument", output
  end
end
