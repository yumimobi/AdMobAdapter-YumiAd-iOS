//
//  GADYUMIBannerSampleViewController.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/19.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMIBannerSampleViewController.h"
#import <GoogleMobileAds/GADBannerView.h>

@interface GADYUMIBannerSampleViewController ()<GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property(nonatomic, strong) GADBannerView *bannerView;

@end

@implementation GADYUMIBannerSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)handleLoadBanner:(UIButton *)sender {
    
    if (!self.bannerView) {
        self.bannerView = [[GADBannerView alloc]
                           initWithAdSize:kGADAdSizeBanner];
        
        [self addBannerViewToView:self.bannerView];
        self.bannerView.adUnitID = @"ca-app-pub-9454875840803246/5385541477";
        self.bannerView.rootViewController = self;
        self.bannerView.delegate = self;
    }
    
    GADRequest *request = [GADRequest request];
    
    [self.bannerView loadRequest:request];
    [self addLog:@"load banner..."];
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

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

#pragma mark: GADBannerViewDelegate

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    
    [self addLog:@"adViewDidReceiveAd"];
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    
    [self addLog:[NSString stringWithFormat:@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]]];
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    [self addLog:@"adViewWillPresentScreen"];
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    [self addLog:@"adViewDidDismissScreen"];
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    [self addLog:@"adViewWillLeaveApplication"];
}

@end
