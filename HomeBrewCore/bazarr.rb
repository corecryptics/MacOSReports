require "language/node"

class Bazarr < Formula
  include Language::Python::Virtualenv

  desc "Companion to Sonarr and Radarr for managing and downloading subtitles"
  homepage "https://www.bazarr.media"
  license "GPL-3.0-or-later"
  head "https://github.com/morpheus65535/bazarr.git", branch: "master"

  stable do
    url "https://github.com/morpheus65535/bazarr/releases/download/v1.1.1/bazarr.zip"
    sha256 "0a55474e185c7f84246218097af4caae805ed33d18657f37a8a141d2d847e9e3"
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7e7502fd86287ae876a205a97f46324d76b5866decce960cdd46638d567b1797"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "056148533d39abdebd1cd5112778a2cfa97a9a4f55fcc3c5f49df41c1a28f049"
    sha256 cellar: :any_skip_relocation, monterey:       "998fedfaacdcff31fdf5d9c91aef1bf01a006b1c1f5fad219f37e9ea56346f20"
    sha256 cellar: :any_skip_relocation, big_sur:        "17050d67fdcbff24d19571e305bcf3bdd86edf1d05e9989e97ba48ae4db0c68c"
    sha256 cellar: :any_skip_relocation, catalina:       "6283d6605df7f70ab72ba22c0f6694959beb38eedf0add8be20f281effaf0704"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4bf2d80f9e08a9f27a0b3a9da0c39057b5a6d9d4fffd21211276446cea195dd2"
  end

  depends_on "node" => :build
  depends_on "ffmpeg"
  depends_on "gcc"
  depends_on "numpy"
  depends_on "pillow"
  depends_on "python@3.10"
  depends_on "unar"

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"
  uses_from_macos "zlib"

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/3b/94/e2b1b3bad91d15526c7e38918795883cee18b93f6785ea8ecf13f8ffa01e/lxml-4.8.0.tar.gz"
    sha256 "f63f62fc60e6228a4ca9abae28228f35e1bd3ce675013d1dfb828688d50c6e23"
  end

  resource "webrtcvad-wheels" do
    url "https://files.pythonhosted.org/packages/1c/37/56ddf05b6eaf4023b2d3eb069954fd9150b452ee326d0ea20af1d0d4b0c2/webrtcvad-wheels-2.0.10.post2.tar.gz"
    sha256 "151bf3998fb731afff90dba77808326235370a6bb467a2d1b81345b10d1de10d"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/Language::Python.site_packages("python3.10")
    venv = virtualenv_create(libexec, "python3.10")

    venv.pip_install resources

    if build.head?
      # Build front-end.
      cd buildpath/"frontend" do
        system "npm", "install", *Language::Node.local_npm_install_args
        system "npm", "run", "build"
      end
    end

    # Stop program from automatically downloading its own binaries.
    binaries_file = buildpath/"bazarr/utilities/binaries.json"
    rm binaries_file
    binaries_file.write "[]"

    libexec.install Dir["*"]
    (bin/"bazarr").write_env_script libexec/"bin/python", "#{libexec}/bazarr.py",
      NO_UPDATE:  "1",
      PATH:       "#{Formula["ffmpeg"].opt_bin}:#{HOMEBREW_PREFIX/"bin"}:$PATH",
      PYTHONPATH: ENV["PYTHONPATH"]

    (libexec/"data").install_symlink pkgetc => "config"
  end

  def post_install
    pkgetc.mkpath
  end

  plist_options startup: true
  service do
    run opt_bin/"bazarr"
    keep_alive true
    log_path var/"log/bazarr.log"
    error_log_path var/"log/bazarr.log"
  end

  test do
    system "#{bin}/bazarr", "--help"

    port = free_port

    pid = fork do
      exec "#{bin}/bazarr", "--config", testpath, "-p", port.to_s
    end
    sleep 20

    begin
      assert_match "<title>Bazarr</title>", shell_output("curl --silent http://localhost:#{port}")
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
