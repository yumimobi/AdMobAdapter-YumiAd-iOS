Pod::Spec.new do |s|
  s.name = "YumiAdSDKAdapterAdmob"
  version = "4.5.1.100"
  s.version = version
  s.summary = "Yumi SDK."
  s.license = "Custom"
  s.authors = {"zplay sdk team"=>"ad-client@zplay.cn"}
  s.homepage = "http://yumimobi.com/"
  s.description = "This is the Yumi SDK. Please proceed to http://developers.yumimobi.com/IosSdk/index for more information."
  s.source = {:git => 'https://github.com/yumimobi/AdMobAdapter-YumiAd-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target    = '8.0'
  s.source_files = 'AdMobAdapter-YumiAd-iOS/YumiAdapters/**/*.{h,m}'
  s.dependency 'YumiAdSDK','4.5.1.100'
  s.dependency 'Google-Mobile-Ads-SDK'
  s.static_framework = true

end