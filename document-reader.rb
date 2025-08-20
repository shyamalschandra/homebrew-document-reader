class DocumentReader < Formula
  desc "Convert PDF documents to M3U playlists and play them in VLC"
  homepage "https://github.com/shyamalschandra/Document-Reader-I"
  version "1.0.0"
  
  url "https://github.com/shyamalschandra/document-reader-releases/releases/download/v1.0.0/document-reader-v1.0.0-macos.tar.gz"
  sha256 "a398a5106e5e09bf7fd98e3f686268696e02a38b35552ffea3d9cdbdf73ad3ee"
  
  depends_on :macos
  
  def install
    # Install CLI binary
    bin.install "document-reader"
    
    # Install GUI app
    app_dir = prefix/"DocumentReader.app"
    app_dir.mkpath
    
    # Create app bundle structure
    contents_dir = app_dir/"Contents"
    contents_dir.mkpath
    
    macos_dir = contents_dir/"MacOS"
    macos_dir.mkpath
    
    # Copy GUI binary
    system "cp", "DocumentReaderGUI", macos_dir/"DocumentReader"
    
    # Create Info.plist
    info_plist = contents_dir/"Info.plist"
    info_plist.write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>CFBundleExecutable</key>
          <string>DocumentReader</string>
          <key>CFBundleIdentifier</key>
          <string>com.shyamalschandra.document-reader</string>
          <key>CFBundleName</key>
          <string>Document Reader</string>
          <key>CFBundleVersion</key>
          <string>1.0.0</string>
          <key>CFBundleShortVersionString</key>
          <string>1.0.0</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>CFBundleSignature</key>
          <string>????</string>
          <key>LSMinimumSystemVersion</key>
          <string>13.0</string>
          <key>NSHighResolutionCapable</key>
          <true/>
      </dict>
      </plist>
    PLIST
    
    # Make executable
    system "chmod", "+x", macos_dir/"DocumentReader"
  end
  
  test do
    # Test CLI help
    system "#{bin}/document-reader", "--help"
    
    # Test CLI version
    system "#{bin}/document-reader", "--version"
  end
  
  def caveats
    <<~EOS
      Document Reader has been installed!
      
      CLI Usage:
        document-reader <pdf-file> [options]
      
      GUI Usage:
        Open DocumentReader.app from Applications folder
      
      Requirements:
        - macOS 13.0 or later
        - VLC media player (install via: brew install --cask vlc)
      
      For more information, visit: https://github.com/shyamalschandra/Document-Reader-I
    EOS
  end
end
