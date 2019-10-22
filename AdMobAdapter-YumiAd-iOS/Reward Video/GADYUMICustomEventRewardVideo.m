//
//  GADYUMICustomEventRewardVideo.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/20.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMICustomEventRewardVideo.h"
#import <YumiAdSDK/YumiMediationVideo.h>

static NSString *adapterVersion = @"1.2.0";

@interface GADYUMICustomEventRewardVideo ()<GADMediationRewardedAd,YumiMediationVideoDelegate>

@property (nonatomic,weak) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic,copy) GADMediationRewardedLoadCompletionHandler adLoadCompletionHandler;
@property (nonatomic) YumiMediationVideo *rewardVideo;

@end

@implementation GADYUMICustomEventRewardVideo

#pragma mark: GADMediationAdapter

+ (nullable Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}

+ (GADVersionNumber)adSDKVersion {
    NSString *versionString = adapterVersion;
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 3) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}

+ (GADVersionNumber)version {
    return [self adSDKVersion];
}

+ (void)setUpWithConfiguration:(GADMediationServerConfiguration *)configuration
             completionHandler:(GADMediationAdapterSetUpCompletionBlock)completionHandler {
    completionHandler(nil);
}

- (void)loadRewardedAdForAdConfiguration:(GADMediationRewardedAdConfiguration *)adConfiguration
                       completionHandler:(GADMediationRewardedLoadCompletionHandler)completionHandler {
    NSString *adUnitParameters = adConfiguration.credentials.settings[@"parameter"];
   
    NSDictionary *paramterDict = [self dictionaryWithJsonString:adUnitParameters];
    
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    
    NSString *placementId = paramterDict[@"placementId"];
    NSString *channelId = paramterDict[@"channelId"];
    NSString *versionId = paramterDict[@"versionId"];
    
    self.adLoadCompletionHandler = completionHandler;
    
    self.rewardVideo = [YumiMediationVideo sharedInstance];
    self.rewardVideo.delegate = self;
    // set coreLogicInstance state is init
    [[self.rewardVideo valueForKey:@"coreLogicInstance"] setValue:@(0) forKey:@"state"];
    
    [self.rewardVideo loadAdWithPlacementID:placementId channelID:channelId versionID:versionId];
}

- (void)presentFromViewController:(nonnull UIViewController *)viewController {
    [self.rewardVideo presentFromRootViewController:viewController];
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

#pragma mark: YumiMediationVideoDelegate
/// Tells the delegate that the video ad was received.
- (void)yumiMediationVideoDidReceiveAd:(YumiMediationVideo *)video {
    self.delegate = self.adLoadCompletionHandler(self,nil);
}

/// Tells the delegate that the video ad failed to load.
- (void)yumiMediationVideo:(YumiMediationVideo *)video didFailToLoadWithError:(NSError *)error {
    self.adLoadCompletionHandler(self,error);
}

/// Tells the delegate that the video ad failed to show.
- (void)yumiMediationVideo:(YumiMediationVideo *)video didFailToShowWithError:(NSError *)error {
    [self.delegate didFailToPresentWithError:error];
}

/// Tells the delegate that the video ad opened.
- (void)yumiMediationVideoDidOpen:(YumiMediationVideo *)video {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
}

/// Tells the delegate that the video ad start playing.
- (void)yumiMediationVideoDidStartPlaying:(YumiMediationVideo *)video {
    [self.delegate didStartVideo];
}

/// Tells the delegate that the video ad closed.
/// You can learn about the reward info by examining the ‘isRewarded’ value
- (void)yumiMediationVideoDidClosed:(YumiMediationVideo *)video isRewarded:(BOOL)isRewarded {
   
    if (isRewarded) {
        [self.delegate didEndVideo];
    }
   
    [self.delegate willDismissFullScreenView];
    [self.delegate didDismissFullScreenView];
}

/// Tells the delegate that the video ad has rewarded the user.
- (void)yumiMediationVideoDidReward:(YumiMediationVideo *)video {
    GADAdReward *reward = [[GADAdReward alloc] initWithRewardType:@"Yumi reward video"
                               rewardAmount:[NSDecimalNumber decimalNumberWithString:@"1"]];
    
    [self.delegate didRewardUserWithReward:reward];
}

/// Tells the delegate that the reward video ad has been clicked by the person.
- (void)yumiMediationVideoDidClick:(YumiMediationVideo *)video {
    [self.delegate reportClick];
}

@end
