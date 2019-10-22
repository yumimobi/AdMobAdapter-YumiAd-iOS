//
//  GADYUMICustomEventRewardBasedVideo.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/21.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMICustomEventRewardBasedVideo.h"
#import <YumiAdSDK/YumiMediationVideo.h>

static NSString *adapterVersionString = @"1.1.1";

@interface GADYUMICustomEventRewardBasedVideo ()<YumiMediationVideoDelegate>

@property (nonatomic,weak) id<GADMRewardBasedVideoAdNetworkConnector> connector;
@property (nonatomic) YumiMediationVideo *rewardVideo;

@end

@implementation GADYUMICustomEventRewardBasedVideo

#pragma mark: GADMRewardBasedVideoAdNetworkAdapter

+ (NSString *)adapterVersion {
    return adapterVersionString;
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        self.connector = connector;
    }
    
    return self;
    
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

- (void)setUp {
    [self.connector adapterDidSetUpRewardBasedVideoAd:self];
}

- (void)requestRewardBasedVideoAd {
    
    NSDictionary *paramterDict = [self dictionaryWithJsonString:[self.connector credentials][@"parameter"]];
    
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    
    NSString *placementId = paramterDict[@"placementId"];
    NSString *channelId = paramterDict[@"channelId"];
    NSString *versionId = paramterDict[@"versionId"];
    
    self.rewardVideo = [YumiMediationVideo sharedInstance];
    self.rewardVideo.delegate = self;
    // set coreLogicInstance state is init
    [[self.rewardVideo valueForKey:@"coreLogicInstance"] setValue:@(0) forKey:@"state"];
    
    [self.rewardVideo loadAdWithPlacementID:placementId channelID:channelId versionID:versionId];
    
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    [self.rewardVideo presentFromRootViewController:viewController];
}

- (void)stopBeingDelegate {
    self.rewardVideo.delegate = nil;
    self.rewardVideo = nil;
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
    [self.connector adapterDidReceiveRewardBasedVideoAd:self];
}

/// Tells the delegate that the video ad failed to load.
- (void)yumiMediationVideo:(YumiMediationVideo *)video didFailToLoadWithError:(NSError *)error {
    [self.connector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
}

/// Tells the delegate that the video ad failed to show.
- (void)yumiMediationVideo:(YumiMediationVideo *)video didFailToShowWithError:(NSError *)error {
    
}

/// Tells the delegate that the video ad opened.
- (void)yumiMediationVideoDidOpen:(YumiMediationVideo *)video {
    [self.connector adapterDidOpenRewardBasedVideoAd:self];
}

/// Tells the delegate that the video ad start playing.
- (void)yumiMediationVideoDidStartPlaying:(YumiMediationVideo *)video {
    [self.connector adapterDidStartPlayingRewardBasedVideoAd:self];
}

/// Tells the delegate that the video ad closed.
/// You can learn about the reward info by examining the ‘isRewarded’ value
- (void)yumiMediationVideoDidClosed:(YumiMediationVideo *)video isRewarded:(BOOL)isRewarded {
    
    if (isRewarded) {
        [self.connector adapterDidCompletePlayingRewardBasedVideoAd:self];
    }
    [self.connector adapterDidCloseRewardBasedVideoAd:self];
}

/// Tells the delegate that the video ad has rewarded the user.
- (void)yumiMediationVideoDidReward:(YumiMediationVideo *)video {
    GADAdReward *reward = [[GADAdReward alloc] initWithRewardType:@"Yumi reward video"
                                                     rewardAmount:[NSDecimalNumber decimalNumberWithString:@"1"]];
    
    [self.connector adapter:self didRewardUserWithReward:reward];
}

/// Tells the delegate that the reward video ad has been clicked by the person.
- (void)yumiMediationVideoDidClick:(YumiMediationVideo *)video {
    [self.connector adapterDidGetAdClick:self];
}

@end
