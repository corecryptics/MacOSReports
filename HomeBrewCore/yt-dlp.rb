class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Fork of youtube-dl with additional features and fixes"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/f8/ef/cdf55266ace06a9451e94a594dd57202910f86b24adfc5f5af4c66331322/yt-dlp-2022.9.1.tar.gz"
  sha256 "bc74ee255790043e458197aaf25c6c104fefc9fcda4458f652619447ab4ae0d7"
  license "Unlicense"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "da362312a0d0539c3e62a04fd9be411b48c6040ba7089dea1293e913932a844f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5e8774f5b9551c03d2b68218518f625778fe80382740370c3378a5b170027955"
    sha256 cellar: :any_skip_relocation, monterey:       "756e7da24d90cd2164f941b1427c395f7e04d589e2a9e47b00a6e589404bb1e2"
    sha256 cellar: :any_skip_relocation, big_sur:        "9f80eedbe87391d4e77ada776453d91f377e593b38f948f1365dbd7f44405a31"
    sha256 cellar: :any_skip_relocation, catalina:       "7e27dd65c8c29c6d64eb6d8717a8482868b617737e467f228707e50cbe6fdc62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2fd56e2b61e5534a3b9d3ad96a7778549f368f43fa910709d3d08e8da3518309"
  end

  head do
    url "https://github.com/yt-dlp/yt-dlp.git", branch: "master"
    depends_on "pandoc" => :build
  end

  depends_on "python@3.10"

  resource "Brotli" do
    url "https://files.pythonhosted.org/packages/2a/18/70c32fe9357f3eea18598b23aa9ed29b1711c3001835f7cf99a9818985d0/Brotli-1.0.9.zip"
    sha256 "4d1b810aa0ed773f81dceda2cc7b403d01057458730e309856356d4ef4188438"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/cc/85/319a8a684e8ac6d87a1193090e06b6bbb302717496380e225ee10487c888/certifi-2022.6.15.tar.gz"
    sha256 "84c85a9078b11105f04f3036a9482ae10e4621616db313fe045dd24743a0820d"
  end

  resource "mutagen" do
    url "https://files.pythonhosted.org/packages/f3/d9/2232a4cb9a98e2d2501f7e58d193bc49c956ef23756d7423ba1bd87e386d/mutagen-1.45.1.tar.gz"
    sha256 "6397602efb3c2d7baebd2166ed85731ae1c1d475abca22090b7141ff5034b3e1"
  end

  resource "pycryptodomex" do
    url "https://files.pythonhosted.org/packages/52/0d/6cc95a83f6961a1ca041798d222240890af79b381e97eda3b9b538dba16f/pycryptodomex-3.15.0.tar.gz"
    sha256 "7341f1bb2dadb0d1a0047f34c3a58208a92423cdbd3244d998e4b28df5eac0ed"
  end

  resource "websockets" do
    url "https://files.pythonhosted.org/packages/f8/a3/622d9acbfb9a71144b5d7609906bc648c62e3ca5fdbb1c8cca222949d82c/websockets-10.3.tar.gz"
    sha256 "fc06cc8073c8e87072138ba1e431300e2d408f054b27047d047b549455066ff4"
  end

  def install
    system "make", "pypi-files" if build.head?
    virtualenv_install_with_resources
    man1.install_symlink libexec/"share/man/man1/yt-dlp.1"
    bash_completion.install libexec/"share/bash-completion/completions/yt-dlp"
    zsh_completion.install libexec/"share/zsh/site-functions/_yt-dlp"
    fish_completion.install libexec/"share/fish/vendor_completions.d/yt-dlp.fish"
  end

  test do
    # "History of homebrew-core", uploaded 3 Feb 2020
    system "#{bin}/yt-dlp", "--simulate", "https://www.youtube.com/watch?v=pOtd1cbOP7k"
    # "homebrew", playlist last updated 3 Mar 2020
    system "#{bin}/yt-dlp", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=pOtd1cbOP7k&list=PLMsZ739TZDoLj9u_nob8jBKSC-mZb0Nhj"
  end
end
