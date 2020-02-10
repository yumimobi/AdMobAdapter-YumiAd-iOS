//
//  GADYUMIInterstitialSampleViewController.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/20.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMIInterstitialSampleViewController.h"
#import <GoogleMobileAds/GADInterstitial.h>

@interface GADYUMIInterstitialSampleViewController ()<GADInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation GADYUMIInterstitialSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)handleLoadAd:(UIButton *)sender {
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-9454875840803246/1280960728"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [[GADRequest  alloc] init];
    [self.interstitial loadRequest:request];
    
    [self addLog:@"Load interstitial ..."];
    
}
- (IBAction)handlePresentAd:(UIButton *)sender {
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }else {
        [self addLog:@"Interstitial isn't ready"];
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

#pragma mark: GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    [self addLog:@"interstitialDidReceiveAd"];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    [self addLog:[NSString stringWithFormat:@"interstitial did fail to receive error --- %@ ",error.localizedDescription]];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    [self addLog:@"interstitialWillPresentScreen"];
}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad {
    [self addLog:@"interstitialDidFailToPresentScreen"];
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    [self addLog:@"interstitialDidDismissScreen"];
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    [self addLog:@"interstitialWillLeaveApplication"];
}

@end
