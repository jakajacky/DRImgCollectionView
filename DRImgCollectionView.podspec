Pod::Spec.new do |s|

  s.name         = "DRImgCollectionView"
  s.version      = "1.0.0"
  s.summary      = "无限轮播."

  s.homepage     = "https://github.com/jakajacky/DRImgCollectionView"

  s.license      = "MIT"

  s.author             = { "xqzh" => "xqzh@ideabinder.com" }
 
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/jakajacky/DRImgCollectionView.git", :tag => "#{s.version}" }

  s.source_files  = "DRImgCollectionView/DRImgCollectionView", "DRImgCollectionView/DRImgCollectionView/**/*.{h,m}"

  s.requires_arc = true

end

