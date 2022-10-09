class C7n < Formula
  include Language::Python::Virtualenv

  desc "Rules engine for cloud security, cost optimization, and governance"
  homepage "https://github.com/cloud-custodian/cloud-custodian"
  url "https://github.com/cloud-custodian/cloud-custodian/archive/0.9.18.0.tar.gz"
  sha256 "7b88f4b8935455b6f14c17d848574ac9488e65632034ccbf1fd616c6a6e3c2c8"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f9485276743b1cadf6cbd9a5d0f47e234f6d03028744d557a985585cf4518e2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2cca1f09c4aa1958430e08d1cc0b0fca53f9feed3d22ccda552139dcff4a345d"
    sha256 cellar: :any_skip_relocation, monterey:       "1b98fca2b3f91ce46b891c11626a93db3b0dcf92fc8ac094cd7db90924639413"
    sha256 cellar: :any_skip_relocation, big_sur:        "989907a6191958f74f0bd876684c8a60d1731019fce3b56041ff23db8e9a835d"
    sha256 cellar: :any_skip_relocation, catalina:       "5556595cb12a55be6c82568845d4e8c757b582b6a9d79d139e4396633d2190b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31278cf584af6ec8c6fde6b1d96a15f74b276fd1199e9d5a8d0fc59a92714562"
  end

  depends_on "jsonschema"
  depends_on "libpython-tabulate"
  depends_on "python@3.10"
  depends_on "pyyaml"
  depends_on "six"

  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/05/f8/67851ae4fe5396ba6868c5d84219b81ea6a5d53991a6853616095c30adc0/argcomplete-2.0.0.tar.gz"
    sha256 "6372ad78c89d662035101418ae253668445b391755cfe94ea52f1b9d22425b20"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/2e/6d/cf85550a36487f4f572f463c9ea663d909baf73f0bb36ebe638e1a643b37/boto3-1.24.44.tar.gz"
    sha256 "19d06d2f8271993e583bc13a1e95b3c99f897177dbc7fa4e1ea2afc97982a08e"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/ac/79/91066c4cfe4db9b16901ec40543841279e5ccc6b048b46d1e41de563d342/botocore-1.27.44.tar.gz"
    sha256 "83639fcbc58853a7c1b2270a0aa87d5fabf866ae6db79e37fc16d3dab3fae17e"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/4c/17/559b4d020f4b46e0287a2eddf2d8ebf76318fd3bd495f1625414b052fdc9/docutils-0.17.1.tar.gz"
    sha256 "686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125"
  end

  resource "importlib-metadata" do
    url "https://files.pythonhosted.org/packages/1a/16/441080c907df829016729e71d8bdd42d99b9bdde48b01492ed08912c0aa9/importlib_metadata-4.12.0.tar.gz"
    sha256 "637245b8bab2b6502fcbc752cc4b7a6f6243bb02b31c5c26156ad103d3d45670"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/00/2a/e867e8531cf3e36b41201936b7fa7ba7b5702dbef42922193f05c8976cd6/jmespath-1.0.1.tar.gz"
    sha256 "90261b206d6defd58fdd5e85f478bf633a2901798906be2ad389150c5c60edbe"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/e1/eb/e57c93d5cd5edf8c1d124c831ef916601540db70acd96fa21fe60cef1365/s3transfer-0.6.0.tar.gz"
    sha256 "2ed07d3866f523cc561bf4a00fc5535827981b117dd7876f036b0c1aca42c947"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/6d/d5/e8258b334c9eb8eb78e31be92ea0d5da83ddd9385dc967dd92737604d239/urllib3-1.26.11.tar.gz"
    sha256 "ea6e8fb210b19d950fab93b60c9009226c63a28808bc8386e05301e25883ac0a"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/3b/e3/fb79a1ea5f3a7e9745f688855d3c673f2ef7921639a380ec76f7d4d83a85/zipp-3.8.1.tar.gz"
    sha256 "05b45f1ee8f807d0cc928485ca40a07cb491cf092ff587c0df9cb1fd154848d2"
  end

  def install
    virtualenv_install_with_resources

    # we depend on jsonschema, but that's a separate formula, so install a `.pth` file to link them
    site_packages = Language::Python.site_packages("python3.10")
    jsonschema = Formula["jsonschema"].opt_libexec
    (libexec/site_packages/"homebrew-jsonschema.pth").write jsonschema/site_packages
  end

  test do
    # trim last decimal point version to match semver returned from version command
    assert_match version.major_minor_patch.to_s, shell_output("#{bin}/custodian version")

    (testpath/"good-policy.yml").write <<~EOF
      policies:
      - name: ec2-auto-tag-user
        resource: ec2
        mode:
          type: cloudtrail
          role: arn:aws:iam::{account_id}:role/custodian-auto-tagger
          # note {account_id} is optional. If you put that there instead of
          # your actual account number, when the policy is provisioned it
          # will automatically inherit the account_id properly
          events:
            - RunInstances
        filters:
          - tag:CreatorName: absent
        actions:
          - type: auto-tag-user
            tag: CreatorName
            principal_id_tag: CreatorId
    EOF
    output = shell_output("custodian validate --verbose #{testpath}/good-policy.yml 2>&1")
    assert_match "valid", output
    # has invalid "action" key instead of "actions"
    (testpath/"bad-policy.yml").write <<~EOF
      policies:
      - name: ec2-auto-tag-user
        resource: ec2
        filters:
          - tag:CreatorName: absent
        action:
          - type: auto-tag-user
            tag: CreatorName
            principal_id_tag: CreatorId
    EOF
    output = shell_output("custodian validate --verbose #{testpath}/bad-policy.yml 2>&1", 1)
    assert_match "invalid", output
  end
end
