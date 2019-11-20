//
//  YumiMediationNativeAdapterAdMobConnector.h
//  YumiMediationAdapters
//
//  Created by Michael Tang on 2019/2/11.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <YumiAdSDK/YumiMediationAdapterRegistry.h>
#import <YumiAdSDK/YumiMediationUnifiedNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface YumiMediationNativeAdapterAdMobConnector
    : NSObject <YumiMediationUnifiedNativeAd, YumiMediationNativeAdapterConnectorMedia>

- (void)convertWithNativeData:(nullable GADUnifiedNativeAd *)gadNativeAd
                  withAdapter:(id<YumiMediationNativeAdapter>)adapter
            connectorDelegate:(id<YumiMediationNativeAdapterConnectorDelegate>)connectorDelegate;

@end

NS_ASSUME_NONNULL_END
