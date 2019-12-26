class Pdf2htmlexNew < Formula
  desc "PDF to HTML converter"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX/"
  url "https://github.com/stephengaito/pdf2htmlEX/archive/new-cmake-system.tar.gz"
  sha256 "edd98beb21ae7dd775ebf583cb720979f5f8c49dcdcd3ef4ecf95b043f93f1aa"
  version "new-cmake-system"

  ENV['PDF2HTMLEX_BRANCH'] = "new-cmake-system"

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

  # We use the standard FontForge, but we need to compile it with 
  # configuration options which are very different from those in the 
  # standard Homebrew/Linuxbrew Formula
  #  
#  resource "fontforge" do
#    url "https://github.com/fontforge/fontforge/releases/download/20190801/fontforge-20190801.tar.gz"
#    sha256 "d92075ca783c97dc68433b1ed629b9054a4b4c74ac64c54ced7f691540f70852"
#  end

  # We also use poppler compiled with configuration options which are very 
  # different from those in the standard Homebrew/Linuxbrew Formula
  #
#  resource "poppler" do
#    url "https://poppler.freedesktop.org/poppler-0.83.0.tar.xz"
#    sha256 "685c650d9771e1c340ea222b57c8bd3f7502e2191ccfe8adeb9e638dcb0b799b"
#  end

#  resource "poppler-data" do
#    url "https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz"
#    sha256 "1f9c7e7de9ecd0db6ab287349e31bf815ca108a5a175cf906a90163bdbe32012"
#  end

  def install
#    resource("fontforge").stage do
#      # Fix linker error; see: https://trac.macports.org/ticket/25012
##      ENV.append "LDFLAGS", "-lintl" if OS.mac?
#
#      # Reset ARCHFLAGS to match how we build
#      ENV["ARCHFLAGS"] = "-arch #{MacOS.preferred_arch}" if OS.mac?
#
#      system "./autogen.sh"
#      system "./configure", "--prefix=#{libexec}/fontforge",
#                            "--without-libzmq",
#                            "--without-x",
#                            "--without-iconv",
#                            "--without-libspiro",
#                            "--without-libuninameslist",
#                            "--disable-python-scripting",
#                            "--disable-python-extension"
#      system "make"
#      system "make", "install"
#    end
#
#    ENV.prepend_path "PKG_CONFIG_PATH", "#{libexec}/fontforge/lib/pkgconfig"
#    ENV.prepend_path "PATH", "#{libexec}/fontforge/bin"
#
#    resource("poppler").stage do
#      inreplace "poppler.pc.in", "Cflags: -I${includedir}/poppler",
#                                 "Cflags: -I${includedir}/poppler -I${includedir}"
#
#      system "./configure", "--disable-dependency-tracking",
#                            "--prefix=#{libexec}/poppler",
#                            "--enable-xpdf-headers",
#                            "--enable-poppler-glib",
#                            "--disable-gtk-test",
#                            "--enable-introspection=no",
#                            "--disable-poppler-qt4"
#      system "make", "install"
#      resource("poppler-data").stage do
#        system "make", "install", "prefix=#{libexec}/poppler"
#      end
#    end
#
#    ENV.prepend_path "PKG_CONFIG_PATH", "#{libexec}/poppler/lib/pkgconfig"
#    ENV.prepend_path "PATH", "#{libexec}/poppler/bin"

    system "./buildScripts/versionEnvs"
    system "./buildScripts/reportEnvs"
    system "./buildScripts/getPoppler" unless File.directory?("poppler")
    system "./buildScripts/buildPoppler", *std_cmake_args
    system "./buildScripts/getPopplerData" unless File.directory?("poppler-data")
    system "./buildScripts/getFontforge" unless File.directory?("fontforge")
    system "./buildScripts/buildFontforge" # FontForge does not yet use cmake
    system "./buildScripts/buildPdf2htmlEX", *std_cmake_args
    system "./buildScripts/installPdf2htmlEX"
#    system "cmake", ".", *std_cmake_args
#    system "make"
#    system "make", "install"
  end

  test do
    #system "#{bin}/pdf2htmlEX", test_fixtures("test.pdf")
    system "#{bin}/pdf2htmlEX", "--version"
  end
end
