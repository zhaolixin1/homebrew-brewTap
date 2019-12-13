class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/update-poppler.tar.gz"
  version "update-poppler"
  sha256 "78ea892f7692ded40f4474469baed27206bcee740f17e8bba49f187b02a9d11e"

  bottle do
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc" => :build unless OS.mac?
  depends_on "llvm" => :build if OS.mac?
  depends_on "gnu-getopt"
#  depends_on "fontforge@20170731"
#  depends_on "poppler@0.81.0"
  depends_on "fontforge"
  depends_on "poppler"
  depends_on "ttfautohint"

  def install

    # May need to explicitly:
    #    brew reinstall -s gettext
    # in order to ensure gettext gets built with the same libstdc++/gcc 
    # versions

    Dir.chdir('pdf2htmlEX')
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

#  test do
#    system "#{bin}/pdf2htmlEX", test_fixtures("test.pdf")
#  end
end
