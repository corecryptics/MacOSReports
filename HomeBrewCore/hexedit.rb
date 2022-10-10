class Hexedit < Formula
  desc "View and edit files in hexadecimal or ASCII"
  homepage "http://rigaux.org/hexedit.html"
  url "https://github.com/pixel/hexedit/archive/1.6.tar.gz"
  sha256 "598906131934f88003a6a937fab10542686ce5f661134bc336053e978c4baae3"
  license "GPL-2.0-or-later"
  head "https://github.com/pixel/hexedit.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "036e68e8552287bbf3c4f37232a3eda16f05993b0635573f04f87f9a89b71392"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4127abcc6c5a2dcd8e5b535b89de6bc2a32a5c0f92f26fef10114ad5b03d5c72"
    sha256 cellar: :any_skip_relocation, monterey:       "f24ca3b6ffe8ab46993b0044f5fa94f2663f4122d65ae290ff8355241d41ca0f"
    sha256 cellar: :any_skip_relocation, big_sur:        "145c1c6e983965f64b0e19df3a0c6adaff3577486c42ffbe1e79939ef855d9c5"
    sha256 cellar: :any_skip_relocation, catalina:       "6306cc37f5c56d10fd058db6881681e2406adf397537616b37d45aab2e732964"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26a91b13749f1e68542e41109fed36f4001a23d79a412bf7a5830f2a08ddbe5c"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/hexedit -h 2>&1", 1)
  end
end