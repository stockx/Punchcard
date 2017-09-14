Pod::Spec.new do |s|
  s.name               = "Punchcard"
  s.version            = "1.0.0"
  s.summary            = "A customizable punchcard view written in Swift."
  s.homepage           = "https://github.com/stockx/Punchcard/"
  s.license            = "MIT"
  s.author             = { "Josh Sklar" => "jrmsklar@gmail.com" }
  s.social_media_url   = "https://instagram.com/jrmsklar"
  s.platform           = :ios
  s.platform           = :ios, "8.2"
  s.source             = { :git => "https://github.com/stockx/Punchcard.git", :tag => s.version}
  s.source_files       = "Source/**/*.swift"
end
