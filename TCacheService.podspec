
Pod::Spec.new do |s|
    s.name         = "TCacheService"
    s.version      = "0.0.5"
    s.summary      = "cacheService."
    s.homepage     = "https://github.com/geniustag/TCacheService.git"
    s.license      = "MIT"
    s.author       = { "GodL" => "547188371@qq.com" }
    s.platform     = :ios, "6.0"
    s.source       = { :git => "https://github.com/geniustag/TCacheService.git", :tag => s.version.to_s }
s.source_files  = "TCacheService/*.{h,m}"
    s.framework  = "UIKit"
    s.dependency "FHCategory"
    s.dependency "TMarco"
    s.requires_arc = true
end
