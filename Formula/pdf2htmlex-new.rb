class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/new-cmake-system.tar.gz"
  sha256 "e497a119a37da7ab3e1e799a064410ca9165f10e0a9d10b5302ae01241788236"
  version "new-cmake-system"

  # set the basic environment variables for the buildScripts
  #
  ENV['PDF2HTMLEX_BRANCH'] = "new-cmake-system"
  ENV['UNATTENDED']        = "--assume-yes"

  bottle do
  end

  # build tools
  #
  depends_on "autoconf" => :build # for fontforge
  depends_on "automake" => :build # for fontforge
  depends_on "cmake" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  #
  # development libraries
  #
  depends_on "cairo" # for fontforge and poppler
  depends_on "freetype" # for fontforge and poppler
  depends_on "gettext" # for fontforge
#  depends_on "giflib" # for fontforge
  depends_on "glib" # for fontforge and poppler
  depends_on "gnu-getopt"
  depends_on "jpeg" # for fontforge
  depends_on "libpng" # for fontforge
#  depends_on "libtiff" # for fontforge
  depends_on "libtool" # for fontforge
#  depends_on "openjpeg" # for poppler
  depends_on "pango" # for fontforge
  depends_on "ttfautohint"
  depends_on "libxml2"
  depends_on "lcms2"

  def install
    # set the basic environment variables for the buildScripts
    #
    ENV['PDF2HTMLEX_PREFIX'] = "#{prefix}" # prefix is only defined inside install

    system "./buildScripts/versionEnvs"
    system "./buildScripts/reportEnvs"
    system "./buildScripts/getPoppler"
    system "./buildScripts/buildPoppler", *std_cmake_args
    system "./buildScripts/getPopplerData"
    system "./buildScripts/getFontforge"
    system "./buildScripts/buildFontforge" # FontForge does not yet use cmake
    system "./buildScripts/buildPdf2htmlEX", *std_cmake_args
    system "./buildScripts/installPdf2htmlEX"
  end

  test do
    #system "#{bin}/pdf2htmlEX", test_fixtures("test.pdf")
    system "#{bin}/pdf2htmlEX", "--version"
  end
end
