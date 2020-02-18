//
//  GADYUMICustomEventInterstitial.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/20.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMICustomEventInterstitial.h"
#import <YumiMediationSDK/YumiMediationInterstitial.h>

@interface GADYUMICustomEventInterstitial ()<YumiMediationInterstitialDelegate>

@property (nonatomic)YumiMediationInterstitial *interstitial;

@end

@implementation GADYUMICustomEventInterstitial

#pragma mark: GADCustomEventInterstitial

@synthesize delegate;

- (void)requestInterstitialAdWithParameter:(nullable NSString *)serverParameter
                                     label:(nullable NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request {
    NSDictionary *paramterDict = [self dictionaryWithJsonString:serverParameter];
    
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    
    NSString *placementId = paramterDict[@"placementId"];
    NSString *channelId = paramterDict[@"channelId"];
    NSString *versionId = paramterDict[@"versionId"];
    self.interstitial = [[YumiMediationInterstitial alloc] initWithPlacementID:placementId channelID:channelId versionID:versionId];
    self.interstitial.delegate = self;
    self.interstitial.initByOtherMediation = YES;
    
}

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    [self.interstitial presentFromRootViewController:nil];
}

#pragma mark: private
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark: YumiMediationInterstitialDelegate
/// Tells the delegate that the interstitial ad request succeeded.
- (void)yumiMediationInterstitialDidReceiveAd:(YumiMediationInterstitial *)interstitial {
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

/// Tells the delegate that the interstitial ad failed to load.
- (void)yumiMediationInterstitial:(YumiMediationInterstitial *)interstitial
           didFailToLoadWithError:(YumiMediationError *)error {
    
    [self.delegate customEventInterstitial:self didFailAd:error];
}

/// Tells the delegate that the interstitial ad failed to show.
- (void)yumiMediationInterstitial:(YumiMediationInterstitial *)interstitial
           didFailToShowWithError:(YumiMediationError *)error {
    
}

/// Tells the delegate that the interstitial ad opened.
- (void)yumiMediationInterstitialDidOpen:(YumiMediationInterstitial *)interstitial {
    [self.delegate customEventInterstitialWillPresent:self];
}

/// Tells the delegate that the interstitial ad start playing.
- (void)yumiMediationInterstitialDidStartPlaying:(YumiMediationInterstitial *)interstitial {
    
}

/// Tells the delegate that the interstitial is to be animated off the screen.
- (void)yumiMediationInterstitialDidClosed:(YumiMediationInterstitial *)interstitial {
    [self.delegate customEventInterstitialWillDismiss:self];
    [self.delegate customEventInterstitialDidDismiss:self];
}

/// Tells the delegate that the interstitial ad has been clicked.
- (void)yumiMediationInterstitialDidClick:(YumiMediationInterstitial *)interstitial {
    [self.delegate customEventInterstitialWasClicked:self];
}

@end
