class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/newBuildSystem.tar.gz"
  version "newBuildSystem"
  sha256 "dadcacdec16bf2c7ca10a86bbdf492a4b725c609d83ccf2b16d92f291caf2d19"

  bottle do
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc" => :build
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
  end

#  test do
#    system "#{bin}/pdf2htmlEX", test_fixtures("test.pdf")
#  end
end
