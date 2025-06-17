class Avalan < Formula
  include Language::Python::Virtualenv

  desc "The multi-backend, multi-modal framework for effortless AI agent development, orchestration, and deployment."
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/0a/f7/01d43b74c00b63e398af873d627b5a0156b679c1bf342b11c9339bf7aea0/avalan-1.1.1.tar.gz"
  sha256 "d05e4f8e3d3a8f8db3912f3cc786ed9c53e2d4f80750fc03c12bfd7a6b5b5f9c"
  license "MIT"

  depends_on "python@3.11"
  depends_on "poetry" => :build
  depends_on "cmake"
  depends_on "pkg-config"
  depends_on "protobuf"
  depends_on "sentencepiece"

  def install
    system "poetry", "export",
                      "--without-hashes",
                      "--format=requirements.txt",
                      "--extras", "all",
                      "--output", "requirements.txt"

    venv = virtualenv_create(libexec, "python3")
    venv.pip_install Pathname("requirements.txt")
    venv.pip_install_and_link buildpath

    bin.install Dir[libexec/"bin/*"]
  end

  test do
    assert_match "avalan 1.1.1", shell_output("#{bin}/avalan --version")
  end
end

