Pod::Spec.new do |s|
  s.name         = "ZYPinYinSearch"
  s.version      = "2.0.1"
  s.ios.deployment_target = '6.0'
  s.summary      = "iOS汉语拼音搜索"
  s.homepage     = "https://github.com/bjzhangyang/ZYPinYinSearch"
  s.license      = "MIT"
  s.author             = { "bjzhangyang" => "348487330@qq.com" }
  s.source       = { :git => "https://github.com/bjzhangyang/ZYPinYinSearch", :tag => s.version }
  s.source_files  = "ZYPinYinSearch/ZYPinYinSearchLib/*"
  s.requires_arc = true
end
