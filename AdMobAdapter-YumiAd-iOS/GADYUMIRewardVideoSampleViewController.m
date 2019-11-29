//
//  GADYUMIRewardVideoSampleViewController.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/20.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMIRewardVideoSampleViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GADYUMIRewardVideoSampleViewController () <GADRewardedAdMetadataDelegate,GADRewardedAdDelegate>

@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property(nonatomic, strong) GADRewardedAd *rewardedAd;

@end

@implementation GADYUMIRewardVideoSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)handleLoadVideo:(UIButton *)sender {
    self.rewardedAd = [[GADRewardedAd alloc]
                       initWithAdUnitID:@"ca-app-pub-9454875840803246/3417853680"];
    self.rewardedAd.adMetadataDelegate = self;
    
    __weak typeof(self) weakSelf = self;
    
    GADRequest *request = [[GADRequest  alloc] init];
    [self.rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        if (error) {
            [weakSelf addLog:[NSString stringWithFormat:@"load error ,-- %@",error.localizedDescription]];
            return ;
        }
        [weakSelf addLog:@"reward video load success"];
    }];
    
    [self addLog:@"load reward video ..."];
}

- (IBAction)handleShowAd:(UIButton *)sender {
    if (self.rewardedAd.isReady) {
        [self.rewardedAd presentFromRootViewController:self delegate:self];
    }else{
        [self addLog:@"reward video is`t ready"];
    }
}

#pragma mark: private method
- (void)addLog:(NSString *)newLog {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.logTextView.layoutManager.allowsNonContiguousLayout = NO;
        NSString *oldLog = weakSelf.logTextView.text;
        NSString *text = [NSString stringWithFormat:@"%@\n%@", oldLog, newLog];
        if (oldLog.length == 0) {
            text = [NSString stringWithFormat:@"%@", newLog];
        }
        [weakSelf.logTextView scrollRangeToVisible:NSMakeRange(text.length, 1)];
        weakSelf.logTextView.text = text;
    });
}

#pragma mark: GADRewardedAdMetadataDelegate

- (void)rewardedAdMetadataDidChange:(nonnull GADRewardedAd *)rewardedAd {
    
}

#pragma mark: GADRewardedAdDelegate
/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(nonnull GADRewardedAd *)rewardedAd
 userDidEarnReward:(nonnull GADAdReward *)reward {
    [self addLog:@"rewardedAd userDidEarnReward"];
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(nonnull GADRewardedAd *)rewardedAd
didFailToPresentWithError:(nonnull NSError *)error {
    [self addLog:[NSString stringWithFormat:@"reward video did fail to present error is -- %@",error.localizedDescription]];
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(nonnull GADRewardedAd *)rewardedAd {
    [self addLog:@"rewardedAdDidPresent"];
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(nonnull GADRewardedAd *)rewardedAd {
    [self addLog:@"rewardedAdDidDismiss"];
}

@end
