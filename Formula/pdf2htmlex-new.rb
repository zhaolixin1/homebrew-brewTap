class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/newBuildSystem.tar.gz"
  version "newBuildSystem"
  sha256 "b9f903dd36b77af5ecf958f8576596a805ac74d3befad37a28baea75e8a0d66c"

  bottle do
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc" => :build unless OS.mac?
  depends_on "llvm" => :build if OS.mac?
  depends_on "gnu-getopt"
  depends_on "fontforge@20170731"
  depends_on "poppler@0.81.0"
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
    pdf2htmlPath = `which pdf2htmlEX`
    system "otool", "-L", pdf2htmlPath.to_s if OS.mac?
    system "ldd", pdf2htmlPath.to_s unless OS.mac?
  end

#  test do
#    system "#{bin}/pdf2htmlEX", test_fixtures("test.pdf")
#  end
end
