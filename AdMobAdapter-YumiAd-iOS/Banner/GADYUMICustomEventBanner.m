//
//  GADYUMICustomEventBanner.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/19.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMICustomEventBanner.h"
#import <YumiAdSDK/YumiMediationBannerView.h>
#import <YumiAdSDK/YumiTool.h>

@interface GADYUMICustomEventBanner ()<YumiMediationBannerViewDelegate>

@property (nonatomic) YumiMediationBannerView *bannerView;

@end

@implementation GADYUMICustomEventBanner

@synthesize delegate;

#pragma mark: GADCustomEventBanner
- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(nullable NSString *)serverParameter
                  label:(nullable NSString *)serverLabel
                request:(GADCustomEventRequest *)request {
    
    NSDictionary *paramterDict = [self dictionaryWithJsonString:serverParameter];
   
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    
    NSString *placementId = paramterDict[@"placementId"];
    NSString *channelId = paramterDict[@"channelId"];
    NSString *versionId = paramterDict[@"versionId"];
    
    self.bannerView = [[YumiMediationBannerView alloc] initWithPlacementID:placementId channelID:channelId versionID:versionId position:YumiMediationBannerPositionBottom rootViewController:[self.delegate viewControllerForPresentingModalView]];
    
    self.bannerView.delegate = self;
    [self.bannerView disableAutoRefresh];
    self.bannerView.isIntegrated = YES;
    
    [self.bannerView loadAd:NO];
}

#pragma mark: private
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark: YumiMediationBannerViewDelegate
/// Tells the delegate that an ad has been successfully loaded.
- (void)yumiMediationBannerViewDidLoad:(YumiMediationBannerView *)adView {
    [self.delegate customEventBanner:self didReceiveAd:adView];
}

/// Tells the delegate that a request failed.
- (void)yumiMediationBannerView:(YumiMediationBannerView *)adView didFailWithError:(YumiMediationError *)error {
 
    [self.delegate customEventBanner:self didFailAd:error];
}

/// Tells the delegate that the banner view has been clicked.
- (void)yumiMediationBannerViewDidClick:(YumiMediationBannerView *)adView {
    [self.delegate customEventBannerWasClicked:self];
    [self.delegate customEventBannerWillLeaveApplication:self];
}

@end
