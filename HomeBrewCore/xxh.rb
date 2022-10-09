class Xxh < Formula
  include Language::Python::Virtualenv

  desc "Bring your favorite shell wherever you go through the ssh"
  homepage "https://github.com/xxh/xxh"
  url "https://files.pythonhosted.org/packages/63/71/7b985e754543e4fc9fc53cf36f405ee5b8044931cffa45898c4edf74275a/xxh-xxh-0.8.10.tar.gz"
  sha256 "5afe1d9803143e3b6659f48a6e4ec8134b952046e8efd9089b791aeeb8fe1045"
  license "BSD-2-Clause"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "203d79b112f0fd23f5c87f2c4dadb9c58a94e2613170949c7d87c81d3d2885eb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a70087dbbfdebc259c28bcebfe3eeac7decac236f5340ec59e13d7358c8df86a"
    sha256 cellar: :any_skip_relocation, monterey:       "4344c6ef7bb5861607803d56ad06793763d43eb9140560fa1f841c858278c3dd"
    sha256 cellar: :any_skip_relocation, big_sur:        "154b334902fd0cafa8b4368b81efd263ce8046cb381157a63fe465ae6c078b93"
    sha256 cellar: :any_skip_relocation, catalina:       "664a078f0eaf8a6835d5f4d21e9e8e2610d86bffac901e2cb051e5653a64f570"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9fe913e693da1c8b9f05173cd63fae50d1b08bf589c48d4bc9814dc7c84d1b0b"
  end

  depends_on "python@3.10"
  depends_on "pyyaml"

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/e5/9b/ff402e0e930e70467a7178abb7c128709a30dfb22d8777c043e501bc1b10/pexpect-4.8.0.tar.gz"
    sha256 "fc65a43959d153d0114afe13997d439c22823a27cefceb5ff35c2178c6784c0c"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz"
    sha256 "5c5d0a3b48ceee0b48485e0c26037c0acd7d29765ca3fbb5cb3831d347423220"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xxh --version")

    (testpath/"config.xxhc").write <<~EOS
      hosts:
        test.localhost:
          -o: HostName=127.0.0.1
          +s: xxh-shell-zsh
    EOS
    begin
      port = free_port
      server = TCPServer.new(port)
      server_pid = fork do
        msg = server.accept.gets
        server.close
        assert_match "SSH", msg
      end

      stdout, stderr, = Open3.capture3(
        "#{bin}/xxh", "test.localhost",
        "-p", port.to_s,
        "+xc", "#{testpath}/config.xxhc",
        "+v"
      )

      argv = stdout.lines.grep(/^Final arguments list:/).first.split(":").second
      args = JSON.parse argv.tr("'", "\"")
      assert_includes args, "xxh-shell-zsh"

      ssh_argv = stderr.lines.grep(/^ssh arguments:/).first.split(":").second
      ssh_args = JSON.parse ssh_argv.tr("'", "\"")
      assert_includes ssh_args, "Port=#{port}"
      assert_includes ssh_args, "HostName=127.0.0.1"
      assert_match "Connection closed by remote host", stderr
    ensure
      Process.kill("TERM", server_pid)
    end
  end
end
