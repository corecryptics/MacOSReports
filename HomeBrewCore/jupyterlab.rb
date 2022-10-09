class Jupyterlab < Formula
  include Language::Python::Virtualenv

  desc "Interactive environments for writing and running code"
  homepage "https://jupyter.org/"
  url "https://files.pythonhosted.org/packages/e4/8b/86130313d04506d5f2043e6ec856b287d9c6c976aa4a32a4215d25826779/jupyterlab-3.4.7.tar.gz"
  sha256 "4dc48ab0980e3af2e921dff26e0013dd03b104b1b67f0d85b67448e16e25311e"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "beb8bfb2274e8bfcae0d7466d25d8e68d2c5dc529eb5b069513aa75b65bb84d6"
    sha256 cellar: :any,                 arm64_big_sur:  "04152d5a6c2d49fe98ed6c4bdd7e14968995334fd29d7a0e354c3ecc0592cf71"
    sha256 cellar: :any,                 monterey:       "93cf3a7f474b822deb5b960ed4ecbace1ff43b17e01d777c66e2acec55987174"
    sha256 cellar: :any,                 big_sur:        "5ae93142c8010d3e5f0cc9c3dd6a5a6e6c90cc4a14d381c03a1a7bde998a6439"
    sha256 cellar: :any,                 catalina:       "be60432506b980734cc2c9dc4e8e5f955c10a4772ec0450d8c6b8f00a9cfb44a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "65d2d5ff7c89a943fb870cb6c6155e6f6e9508a6ec101b67eafdb3e5daf3e0dc"
  end

  depends_on "python-build" => :build
  depends_on "node"
  depends_on "pandoc"
  depends_on "python@3.10"
  depends_on "six"
  depends_on "zeromq"

  uses_from_macos "expect" => :test
  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/67/c4/fd50bbb2fb72532a4b778562e28ba581da15067cfb2537dbd3a2e64689c1/anyio-3.6.1.tar.gz"
    sha256 "413adf95f93886e442aea925f3ee43baa5a765a64a0f52c6081894f9992fdd0b"
  end

  resource "appnope" do
    url "https://files.pythonhosted.org/packages/6a/cd/355842c0db33192ac0fc822e2dcae835669ef317fe56c795fb55fcddb26f/appnope-0.1.3.tar.gz"
    sha256 "02bd91c4de869fbb1e1c50aafc4098827a7a54ab2f39d9dcba6c9547ed920e24"
  end

  resource "argon2-cffi" do
    url "https://files.pythonhosted.org/packages/3f/18/20bb5b6bf55e55d14558b57afc3d4476349ab90e0c43e60f27a7c2187289/argon2-cffi-21.3.0.tar.gz"
    sha256 "d384164d944190a7dd7ef22c6aa3ff197da12962bd04b17f64d4e93d934dba5b"
  end

  resource "argon2-cffi-bindings" do
    url "https://files.pythonhosted.org/packages/b9/e9/184b8ccce6683b0aa2fbb7ba5683ea4b9c5763f1356347f1312c32e3c66e/argon2-cffi-bindings-21.2.0.tar.gz"
    sha256 "bb89ceffa6c791807d1305ceb77dbfacc5aa499891d2c55661c6459651fc39e3"
  end

  resource "asttokens" do
    url "https://files.pythonhosted.org/packages/4d/c8/987ee029c83ad1cddb03bb004e9c7a8de1be4cdbda21122a0b9f639fcc31/asttokens-2.0.8.tar.gz"
    sha256 "c61e16246ecfb2cde2958406b4c8ebc043c9e6d73aaa83c941673b35e5d3a76b"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/1a/cb/c4ffeb41e7137b23755a45e1bfec9cbb76ecf51874c6f1d113984ecaa32c/attrs-22.1.0.tar.gz"
    sha256 "29adc2665447e5191d0e7c568fde78b21f9672d344281d0c6e1ab085429b22b6"
  end

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/51/27/81e9cf804a34a550a47cc2f0f57fe4935281d479ae3a0ac093d69476f221/Babel-2.10.3.tar.gz"
    sha256 "7614553711ee97490f732126dc077f8d0ae084ebc6a96e23db1482afabdb2c51"
  end

  resource "backcall" do
    url "https://files.pythonhosted.org/packages/a2/40/764a663805d84deee23043e1426a9175567db89c8b3287b5c2ad9f71aa93/backcall-0.2.0.tar.gz"
    sha256 "5cbdbf27be5e7cfadb448baf0aa95508f91f2bbc6c6437cd9cd06e2a4c215e1e"
  end

  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/e8/b0/cd2b968000577ec5ce6c741a54d846dfa402372369b8b6861720aa9ecea7/beautifulsoup4-4.11.1.tar.gz"
    sha256 "ad9aa55b65ef2808eb405f46cf74df7fcb7044d5cbc26487f96eb2ef2e436693"
  end

  resource "bleach" do
    url "https://files.pythonhosted.org/packages/c2/5d/d5d45a38163ede3342d6ac1ca01b5d387329daadf534a25718f9a9ba818c/bleach-5.0.1.tar.gz"
    sha256 "0d03255c47eb9bd2f26aa9bb7f2107732e7e8fe195ca2f64709fcf3b0a4a085c"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/05/a8/e0966dcf948a9ab9321f23f121a37b96be191b15dc28e9134927fd42a8af/certifi-2022.6.15.2.tar.gz"
    sha256 "aa08c101214127b9b0472ca6338315113c9487d45376fd3e669201b477c71003"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz"
    sha256 "d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "debugpy" do
    url "https://files.pythonhosted.org/packages/8f/23/8dd369ef3a92bf5fdb4bf0cb84b721efbec43ae81b4f3694f6214b20d6d6/debugpy-1.6.3.zip"
    sha256 "e8922090514a890eec99cfb991bab872dd2e353ebb793164d5f01c362b9a40bf"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/66/0c/8d907af351aa16b42caae42f9d6aa37b900c67308052d10fdce809f8d952/decorator-5.1.1.tar.gz"
    sha256 "637996211036b6385ef91435e4fae22989472f9d571faba8927ba8253acbc330"
  end

  resource "defusedxml" do
    url "https://files.pythonhosted.org/packages/0f/d5/c66da9b79e5bdb124974bfe172b4daf3c984ebd9c2a06e2b8a4dc7331c72/defusedxml-0.7.1.tar.gz"
    sha256 "1bb3032db185915b62d7c6209c5a8792be6a32ab2fedacc84e01b52c51aa3e69"
  end

  resource "entrypoints" do
    url "https://files.pythonhosted.org/packages/ea/8d/a7121ffe5f402dc015277d2d31eb82d2187334503a011c18f2e78ecbb9b2/entrypoints-0.4.tar.gz"
    sha256 "b706eddaa9218a19ebcd67b56818f05bb27589b1ca9e8d797b74affad4ccacd4"
  end

  resource "executing" do
    url "https://files.pythonhosted.org/packages/7e/f7/148b1a293f8187b0ea5327be6ec595731bf2b0dde8d6dae9c907a1ecd704/executing-1.0.0.tar.gz"
    sha256 "98daefa9d1916a4f0d944880d5aeaf079e05585689bebd9ff9b32e31dd5e1017"
  end

  resource "fastjsonschema" do
    url "https://files.pythonhosted.org/packages/2f/ca/b8cd48dde1f4f1811c7ffd49253af87c1cb6523d2aaa5402a83d9fecc197/fastjsonschema-2.16.1.tar.gz"
    sha256 "d6fa3ffbe719768d70e298b9fb847484e2bdfdb7241ed052b8d57a9294a8c334"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "ipykernel" do
    url "https://files.pythonhosted.org/packages/d6/17/9e7273b1ce04eafc422213831c29a13a50251785a95272be245dd2b353d9/ipykernel-6.15.3.tar.gz"
    sha256 "b81d57b0e171670844bf29cdc11562b1010d3da87115c4513e0ee660a8368765"
  end

  resource "ipython" do
    url "https://files.pythonhosted.org/packages/25/a5/dda90aa8cb931458a357ae65ff4341d7694464f322b095a438489440dc7c/ipython-8.5.0.tar.gz"
    sha256 "097bdf5cd87576fd066179c9f7f208004f7a6864ee1b20f37d346c0bcb099f84"
  end

  resource "ipython_genutils" do
    url "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz"
    sha256 "eb2e116e75ecef9d4d228fdc66af54269afa26ab4463042e33785b887c628ba8"
  end

  resource "jedi" do
    url "https://files.pythonhosted.org/packages/c2/25/273288df952e07e3190446efbbb30b0e4871a0d63b4246475f3019d4f55e/jedi-0.18.1.tar.gz"
    sha256 "74137626a64a99c8eb6ae5832d99b3bdd7d29a3850fe2aa80a4126b2a7d949ab"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "json5" do
    url "https://files.pythonhosted.org/packages/47/12/611bf15000c1fc54af909565aed1ad045e5ae1890d8c56cbfe5ceaf52446/json5-0.9.10.tar.gz"
    sha256 "ad9f048c5b5a4c3802524474ce40a622fae789860a86f10cc4f7e5f9cf9b46ab"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/cf/54/8923ba38b5145f2359d57e5516715392491d674c83f446cd4cd133eeb4d6/jsonschema-4.16.0.tar.gz"
    sha256 "165059f076eff6971bae5b742fc029a7b4ef3f9bcf04c14e4776a7605de14b23"
  end

  resource "jupyter-client" do
    url "https://files.pythonhosted.org/packages/4d/d1/b6161a5e8639a0d35aeb59a50d944dc4928775db2408ea10b23087e354b6/jupyter_client-7.3.5.tar.gz"
    sha256 "3c58466a1b8d55dba0bf3ce0834e4f5b7760baf98d1d73db0add6f19de9ecd1d"
  end

  resource "jupyter-core" do
    url "https://files.pythonhosted.org/packages/e4/e0/13fc7f8b72f39d87c1c32918a99475911b7b2f28c1a9f2734a5ab5cc35ef/jupyter_core-4.11.1.tar.gz"
    sha256 "2e5f244d44894c4154d06aeae3419dd7f1b0ef4494dc5584929b398c61cfd314"
  end

  resource "jupyter-server" do
    url "https://files.pythonhosted.org/packages/5b/6e/01af30a3e12d2f8eda1405ca8710442f1e7d05d30f8abbfca3b1f0375ce0/jupyter_server-1.18.1.tar.gz"
    sha256 "2b72fc595bccae292260aad8157a0ead8da2c703ec6ae1bb7b36dbad0e267ea7"
  end

  resource "jupyterlab-pygments" do
    url "https://files.pythonhosted.org/packages/69/8e/8ae01f052013ee578b297499d16fcfafb892927d8e41c1a0054d2f99a569/jupyterlab_pygments-0.2.2.tar.gz"
    sha256 "7405d7fde60819d905a9fa8ce89e4cd830e318cdad22a0030f7a901da705585d"
  end

  resource "jupyterlab-server" do
    url "https://files.pythonhosted.org/packages/c9/12/19935f704a8b2e45d1ce8dfd1253e5651ce16d0fe7865516261eb451dcd0/jupyterlab_server-2.15.1.tar.gz"
    sha256 "305313970e131c590cf77bb6b8ca7e98591bc304111e8d103bc91d212e94796f"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/70/bb/7a2c7b4f8f434aa1ee801704bf08f1e53d7b5feba3d5313ab17003477808/lxml-4.9.1.tar.gz"
    sha256 "fe749b052bb7233fe5d072fcb549221a8cb1a16725c47c37e42b0b9cb3ff2c3f"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end

  resource "matplotlib-inline" do
    url "https://files.pythonhosted.org/packages/d9/50/3af8c0362f26108e54d58c7f38784a3bdae6b9a450bab48ee8482d737f44/matplotlib-inline-0.1.6.tar.gz"
    sha256 "f887e5f10ba98e8d2b150ddcf4702c1e5f8b3a20005eb0f74bfdbd360ee6f304"
  end

  resource "mistune" do
    url "https://files.pythonhosted.org/packages/cd/9b/0f98334812f548a5ee4399b76e33752a74fc7bb976f5efb34d962f03d585/mistune-2.0.4.tar.gz"
    sha256 "9ee0a66053e2267aba772c71e06891fa8f1af6d4b01d5e84e267b4570d4d9808"
  end

  resource "nbclassic" do
    url "https://files.pythonhosted.org/packages/39/0c/87ce838b0436e7c4f52a53d08f3e7ed17482043475594e6c38f6acaa096c/nbclassic-0.4.3.tar.gz"
    sha256 "f03111b2cebaa69b88370a7b23b19b2b37c9bb71767f1828cdfd7a047eae8edd"
  end

  resource "nbclient" do
    url "https://files.pythonhosted.org/packages/01/21/917a25fbc2b37ed37135be97efb4c98526008505451ffa841adcd7d11ed5/nbclient-0.6.8.tar.gz"
    sha256 "268fde3457cafe1539e32eb1c6d796bbedb90b9e92bacd3e43d83413734bb0e8"
  end

  resource "nbconvert" do
    url "https://files.pythonhosted.org/packages/c2/81/8ed17db18332322982cec44123432b75c1f1b1e9205d8573cbd55dd74c90/nbconvert-7.0.0.tar.gz"
    sha256 "fd1e361da30e30e4c5a5ae89f7cae95ca2a4d4407389672473312249a7ba0060"
  end

  resource "nbformat" do
    url "https://files.pythonhosted.org/packages/4f/0e/bc99967de0ccb4871d74fa692fe2bc4a0a6738df1fad140b883c27056bdc/nbformat-5.5.0.tar.gz"
    sha256 "9ebe30e6c3b3e5b47d39ff0a3897a1acf523d2bfafcb4e2d04cdb70f8a66c507"
  end

  resource "nest-asyncio" do
    url "https://files.pythonhosted.org/packages/7b/19/efddf713ba62f738d2bf410a6f5ead6e621f9354d5824091ce8b7a233e11/nest_asyncio-1.5.5.tar.gz"
    sha256 "e442291cd942698be619823a17a86a5759eabe1f8613084790de189fe9e16d65"
  end

  resource "notebook" do
    url "https://files.pythonhosted.org/packages/d5/94/b15c0e44c37e49cf77866ff56cc7644632229b79c113a0eafd908fc7c7d7/notebook-6.4.12.tar.gz"
    sha256 "6268c9ec9048cff7a45405c990c29ac9ca40b0bc3ec29263d218c5e01f2b4e86"
  end

  resource "notebook-shim" do
    url "https://files.pythonhosted.org/packages/80/14/215050c5ee184bd60e7d1e9e7e68d09c4dcacb18d3fb49c1fff4e061b94f/notebook_shim-0.1.0.tar.gz"
    sha256 "7897e47a36d92248925a2143e3596f19c60597708f7bef50d81fcd31d7263e85"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "pandocfilters" do
    url "https://files.pythonhosted.org/packages/62/42/c32476b110a2d25277be875b82b5669f2cdda7897c165bd22b78f366b3cb/pandocfilters-1.5.0.tar.gz"
    sha256 "0b679503337d233b4339a817bfc8c50064e2eff681314376a47cb582305a7a38"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/a2/0e/41f0cca4b85a6ea74d66d2226a7cda8e41206a624f5b330b958ef48e2e52/parso-0.8.3.tar.gz"
    sha256 "8c07be290bb59f03588915921e29e8a50002acaf2cdc5fa0e0114f91709fafa0"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/e5/9b/ff402e0e930e70467a7178abb7c128709a30dfb22d8777c043e501bc1b10/pexpect-4.8.0.tar.gz"
    sha256 "fc65a43959d153d0114afe13997d439c22823a27cefceb5ff35c2178c6784c0c"
  end

  resource "pickleshare" do
    url "https://files.pythonhosted.org/packages/d8/b6/df3c1c9b616e9c0edbc4fbab6ddd09df9535849c64ba51fcb6531c32d4d8/pickleshare-0.7.5.tar.gz"
    sha256 "87683d47965c1da65cdacaf31c8441d12b8044cdec9aca500cd78fc2c683afca"
  end

  resource "prometheus-client" do
    url "https://files.pythonhosted.org/packages/98/71/2f16cce64055263146eff950affe7b1ab2ff78736ff0d2b5578bc0817e49/prometheus_client-0.14.1.tar.gz"
    sha256 "5459c427624961076277fdc6dc50540e2bacb98eebde99886e59ec55ed92093a"
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/80/76/c94cf323ca362dd7baca8d8ddf3b5fe1576848bc0156522ad581c04f8446/prompt_toolkit-3.0.31.tar.gz"
    sha256 "9ada952c9d1787f52ff6d5f3484d0b4df8952787c087edf6a1f7c2cb1ea88148"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/8f/57/828ac1f70badc691a716e77bfae258ef5db76bb7830109bf4bcf882de020/psutil-5.9.2.tar.gz"
    sha256 "feb861a10b6c3bb00701063b37e4afc754f8217f0f09c42280586bd6ac712b5c"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz"
    sha256 "5c5d0a3b48ceee0b48485e0c26037c0acd7d29765ca3fbb5cb3831d347423220"
  end

  resource "pure-eval" do
    url "https://files.pythonhosted.org/packages/97/5a/0bc937c25d3ce4e0a74335222aee05455d6afa2888032185f8ab50cdf6fd/pure_eval-0.2.2.tar.gz"
    sha256 "2b45320af6dfaa1750f543d714b6d1c520a1688dec6fd24d339063ce0aaa9ac3"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/e0/ef/5905cd3642f2337d44143529c941cc3a02e5af16f0f65f81cbef7af452bb/Pygments-2.13.0.tar.gz"
    sha256 "56a8508ae95f98e2b9bdf93a6be5ae3f7d8af858b43e02c5a2ff083726be40c1"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/71/22/207523d16464c40a0310d2d4d8926daffa00ac1f5b1576170a32db749636/pyparsing-3.0.9.tar.gz"
    sha256 "2b020ecf7d21b687f219b71ecad3631f644a47f01403fa1d1036b0c6416d70fb"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/42/ac/455fdc7294acc4d4154b904e80d964cc9aae75b087bbf486be04df9f2abd/pyrsistent-0.18.1.tar.gz"
    sha256 "d4d61f8b993a7255ba714df3aca52700f8125289f84f704cf80916517c46eb96"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/24/0c/401283bb1499768e33ddd2e1a35817c775405c1f047a9dc088a29ce2ea5d/pytz-2022.2.1.tar.gz"
    sha256 "cea221417204f2d1a2aa03ddae3e867921971d0d76f14d87abb4414415bbdcf5"
  end

  resource "pyzmq" do
    url "https://files.pythonhosted.org/packages/72/37/d5603f352522e249e44ee767a8a59b3fe7cf7f708a94fd40a637c6890add/pyzmq-23.2.1.tar.gz"
    sha256 "2b381aa867ece7d0a82f30a0c7f3d4387b7cf2e0697e33efaa5bed6c5784abcd"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "Send2Trash" do
    url "https://files.pythonhosted.org/packages/49/2c/d990b8d5a7378dde856f5a82e36ed9d6061b5f2d00f39dc4317acd9538b4/Send2Trash-1.8.0.tar.gz"
    sha256 "d2c24762fd3759860a0aff155e45871447ea58d2be6bdd39b5c8f966a0c99c2d"
  end

  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/cd/50/d49c388cae4ec10e8109b1b833fd265511840706808576df3ada99ecb0ac/sniffio-1.3.0.tar.gz"
    sha256 "e60305c5e5d314f5389259b7f22aaa33d8f7dee49763119234af3755c55b9101"
  end

  resource "soupsieve" do
    url "https://files.pythonhosted.org/packages/f3/03/bac179d539362319b4779a00764e95f7542f4920084163db6b0fd4742d38/soupsieve-2.3.2.post1.tar.gz"
    sha256 "fc53893b3da2c33de295667a0e19f078c14bf86544af307354de5fcf12a3f30d"
  end

  resource "stack-data" do
    url "https://files.pythonhosted.org/packages/d6/3a/6baf4a5e7b48f00bc636bc878c6d93afd032dfeafc10b4a0a5a27232efb3/stack_data-0.5.0.tar.gz"
    sha256 "715c8855fbf5c43587b141e46cc9d9339cc0d1f8d6e0f98ed0d01c6cb974e29f"
  end

  resource "terminado" do
    url "https://files.pythonhosted.org/packages/4b/27/79dabfeda57d2a878611b41f7d9a401b3b6509c610ec90121a980df0a600/terminado-0.15.0.tar.gz"
    sha256 "ab4eeedccfcc1e6134bfee86106af90852c69d602884ea3a1e8ca6d4486e9bfe"
  end

  resource "tinycss2" do
    url "https://files.pythonhosted.org/packages/1e/5a/576828164b5486f319c4323915b915a8af3fa4a654bbb6f8fc8e87b5cb17/tinycss2-1.1.1.tar.gz"
    sha256 "b2e44dd8883c360c35dd0d1b5aad0b610e5156c2cb3b33434634e539ead9d8bf"
  end

  resource "tomli" do
    url "https://files.pythonhosted.org/packages/c0/3f/d7af728f075fb08564c5949a9c95e44352e23dee646869fa104a3b2060a3/tomli-2.0.1.tar.gz"
    sha256 "de526c12914f0c550d15924c62d72abc48d6fe7364aa87328337a31007fe8a4f"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/f3/9e/225a41452f2d9418d89be5e32cf824c84fe1e639d350d6e8d49db5b7f73a/tornado-6.2.tar.gz"
    sha256 "9b630419bde84ec666bfd7ea0a4cb2a8a651c2d5cccdbdd1972a0c859dfc3c13"
  end

  resource "traitlets" do
    url "https://files.pythonhosted.org/packages/a2/4d/1f59a77fba6e8e9feea7a168652030564089d66c06492ba5670e73b0e078/traitlets-5.4.0.tar.gz"
    sha256 "3f2c4e435e271592fe4390f1746ea56836e3a080f84e7833f0f801d9613fec39"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155/wcwidth-0.2.5.tar.gz"
    sha256 "c4d647b99872929fdb7bdcaa4fbe7f01413ed3d98077df798530e5b04f116c83"
  end

  resource "webencodings" do
    url "https://files.pythonhosted.org/packages/0b/02/ae6ceac1baeda530866a85075641cec12989bd8d31af6d5ab4a3e8c92f47/webencodings-0.5.1.tar.gz"
    sha256 "b36a1c245f2d304965eb4e0a82848379241dc04b865afcc4aab16748587e1923"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/99/11/01fe7ebcb7545a1990c53c11f31230afe1388b0b34256e3fd20e49482245/websocket-client-1.4.1.tar.gz"
    sha256 "f9611eb65c8241a67fb373bef040b3cf8ad377a9f6546a12b620b6511e8ea9ef"
  end

  def python3
    "python3.10"
  end

  def install
    venv = virtualenv_create(libexec, python3)
    ENV["JUPYTER_PATH"] = etc/"jupyter"

    # gather packages to link based on options
    linked = %w[jupyter-core jupyter-client nbformat ipykernel jupyter-console nbconvert notebook]
    dependencies = resources.map(&:name).to_set - linked
    dependencies -= ["appnope"] if OS.linux?

    # `jupyterlab-pygments` requires `jupyterlab` to build. Since Homebrew doesn't
    # allow circular dependencies, we locally build a `jupyterlab-pygments` wheel
    # using the pre-built PyPI wheels for `jupyterlab` and its dependencies.
    dependencies -= ["jupyterlab-pygments"]
    resource("jupyterlab-pygments").stage do
      system "pyproject-build", "--wheel"
      venv.pip_install Dir["dist/jupyterlab_pygments-*.whl"].first
    end

    # install remaining packages into virtualenv and link specified packages
    dependencies.each do |r|
      venv.pip_install resource(r)
    end
    venv.pip_install_and_link linked
    venv.pip_install_and_link buildpath

    # remove bundled kernel
    (libexec/"share/jupyter/kernels").rmtree

    # remove non-native binaries
    if OS.mac? && Hardware::CPU.arm?
      site_packages = libexec/Language::Python.site_packages(python3)
      (site_packages/"debugpy/_vendored/pydevd/pydevd_attach_to_process/attach_x86_64.dylib").unlink
    end

    # install completion
    resource("jupyter-core").stage do
      bash_completion.install "examples/jupyter-completion.bash" => "jupyter"
      zsh_completion.install "examples/completions-zsh" => "_jupyter"
    end
  end

  def caveats
    <<~EOS
      Additional kernels can be installed into the shared jupyter directory
        #{etc}/jupyter
    EOS
  end

  test do
    system bin/"jupyter-console --help"
    assert_match python3, shell_output("#{bin}/jupyter kernelspec list")

    (testpath/"console.exp").write <<~EOS
      spawn #{bin}/jupyter-console
      expect "In "
      send "exit\r"
    EOS
    assert_match "Jupyter console", shell_output("expect -f console.exp")

    (testpath/"notebook.exp").write <<~EOS
      spawn #{bin}/jupyter-notebook --no-browser
      expect "NotebookApp"
    EOS
    assert_match "NotebookApp", shell_output("expect -f notebook.exp")

    (testpath/"nbconvert.ipynb").write <<~EOS
      {
        "cells": []
      }
    EOS
    system bin/"jupyter-nbconvert", "nbconvert.ipynb", "--to", "html"
    assert_predicate testpath/"nbconvert.html", :exist?, "Failed to export HTML"

    assert_match "-F _jupyter",
      shell_output("bash -c \"source #{bash_completion}/jupyter && complete -p jupyter\"")

    # Ensure that jupyter can load the jupyter lab package.
    assert_match(/^jupyterlab *: #{version}$/,
      shell_output(bin/"jupyter --version"))

    # Ensure that jupyter-lab binary was installed by pip.
    assert_equal version.to_s,
      shell_output(bin/"jupyter-lab --version").strip

    port = free_port
    fork { exec "#{bin}/jupyter-lab", "-y", "--port=#{port}", "--no-browser", "--ip=127.0.0.1", "--LabApp.token=''" }
    sleep 10
    assert_match "<title>JupyterLab</title>",
      shell_output("curl --silent --fail http://localhost:#{port}/lab")
  end
end
