class Lout < Formula
  desc "Text formatting like TeX, but simpler"
  homepage "https://savannah.nongnu.org/projects/lout"
  url "https://download.savannah.gnu.org/releases/lout/lout-3.40.tar.gz"
  sha256 "3d16f1ce3373ed96419ba57399c2e4d94f88613c2cb4968cb0331ecac3da68bd"

  bottle do
    sha256 "2f69e0d4097fbf53f05855b5eeb2def0efcaf08c3a5b2487b1fa041031c2eacc" => :mojave
    sha256 "2de1b1b7526f7427b8a57b6239a5a8c199ee05365ead7ed8d722a9e7e3123a0e" => :high_sierra
    sha256 "2cfc68ddba21e6f485a4a57df9e810b6996d5364374c66e77b06d41ce230f060" => :sierra
    sha256 "2fbc90ffc3f12312dc11e31996ba94da3b8a4ba1c55f33ca60a5d81aef4e137f" => :el_capitan
    sha256 "366023d41536d0220a3d226a9f7a5e65b89fcf8ec212bfd6e53f8c2b4110abce" => :yosemite
    sha256 "7cbcdcbf720e5e93c7e8d41861fedbcb0f1b46233414c7897e94671e4e42a9fa" => :mavericks
    sha256 "9d3b44fdc1f1aa2f01ece78c63ad8084897d27758cf72cfbdef6f876c0c7a0cb" => :mountain_lion
  end

  def install
    bin.mkpath
    man1.mkpath
    (doc/"lout").mkpath
    system "make", "PREFIX=#{prefix}", "LOUTLIBDIR=#{lib}", "LOUTDOCDIR=#{doc}", "MANDIR=#{man}", "allinstall"
  end

  test do
    input = "test.lout"
    (testpath/input).write <<~EOS
      @SysInclude { doc }
      @Doc @Text @Begin
      @Display @Heading { Blindtext }
      The quick brown fox jumps over the lazy dog.
      @End @Text
    EOS
    assert_match /^\s+Blindtext\s+The quick brown fox.*\n+$/, shell_output("#{bin}/lout -p #{input}")
  end
end
