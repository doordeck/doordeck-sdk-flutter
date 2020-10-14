#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint doordeck_flutter_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.platform = :ios, '10.0'
  s.name             = 'doordeck_flutter_plugin'
  s.version          = '1.0.0'
  s.social_media_url = "https://twitter.com/doordeck"
  s.summary = "Doordeck allows you to unlock your access control doors via your phone, visit Doordeck.com for more details"
  s.homepage         = 'http://example.com'
  s.license = { :type => "Apache", :file => "../LICENSE" }
  s.author = { "Doordeck" => "support@doordeck.com" }
  s.source           = { :path => '.' }

  s.source_files = 'Classes/**/*.{h,m,swift,storyboard,xib,xcassets,png,jpeg,jpg}'

  s.resources = 'Classes/**/*.{cer,bundle,storyboard}'

  # Dependencies (Flutter + pods needed)
  s.dependency 'Flutter'
  s.dependency 'Alamofire', '~> 5.2.2'
  s.dependency 'Cache', '~> 5.3.0'
  s.dependency 'QRCodeReader.swift', '~> 10.1.0'
  s.dependency 'ReachabilitySwift', '~> 5.0.0'
  s.dependency 'Sodium', '~> 0.8.0'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
