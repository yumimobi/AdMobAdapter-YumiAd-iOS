//
//  GADYUMIViewController.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/19.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMIViewController.h"
#import <GoogleMobileAdsMediationTestSuite/GoogleMobileAdsMediationTestSuite.h>
#import <YumiMediationSDK/YumiMediationGDPRManager.h>

@interface GADYUMIViewController ()

@end

@implementation GADYUMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)handleAdmobTest:(UIButton *)sender {
    [GoogleMobileAdsMediationTestSuite presentWithAppID:@"ca-app-pub-9454875840803246~2667523573"
                                       onViewController:self
                                               delegate:nil];
}


- (IBAction)setYumiGDPRPersonlized:(id)sender {
    [[YumiMediationGDPRManager sharedGDPRManager] updateNetworksConsentStatus:YumiMediationConsentStatusPersonalized];
}

- (IBAction)setYumiGDPRNonPersonlized:(id)sender {
    [[YumiMediationGDPRManager sharedGDPRManager] updateNetworksConsentStatus:YumiMediationConsentStatusNonPersonalized];
}

- (IBAction)setYumiGDPRUnknow:(id)sender {
    [[YumiMediationGDPRManager sharedGDPRManager] updateNetworksConsentStatus:YumiMediationConsentStatusUnknown];
}

@end
