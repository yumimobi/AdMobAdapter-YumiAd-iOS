Pod::Spec.new do |s|
  s.name = "GoogleMobileAdsMediationZplayAds"
  s.version = "4.4.1.000"
  s.summary = "YumiAds adapter used for mediation with the Google Mobile Ads SDK"
  s.license = "Custom"
  s.authors = {"Yumi sdk team"=>"ad-client@yumi.cn"}
  s.homepage = "https://github.com/yumimobi"
  s.description = "YumiAds SDK provides a better ad format for monetizing."
  s.source = {:git => 'https://github.com/yumimobi/AdMobAdapter-YumiAd-iOS.git', :tag => s.version.to_s}
  s.source_files = 'AdMobAdapter-YumiAd-iOS/GoogleAdapters/*.{h,m}'
  s.ios.deployment_target = '9.0'
  s.dependency 'YumiAdSDK', '4.4.1.000'
  s.dependency 'Google-Mobile-Ads-SDK'
end
