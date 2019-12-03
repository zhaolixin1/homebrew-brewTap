class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/newBuildSystem.tar.gz"
  version "newBuildSystem"
  sha256 "43d28b30eb3e6fb6a80b5bcdd61b650338482323778c65307f7a4db5b9ce7340"

  bottle do
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gnu-getopt"
  depends_on "pdf2htmlex-fontforge"
  depends_on "pdf2htmlex-poppler"
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
