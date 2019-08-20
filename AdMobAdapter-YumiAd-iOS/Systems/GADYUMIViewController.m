//
//  GADYUMIViewController.m
//  AdMobAdapter-YumiAd-iOS
//
//  Created by Michael Tang on 2019/8/19.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "GADYUMIViewController.h"
#import <GoogleMobileAdsMediationTestSuite/GoogleMobileAdsMediationTestSuite.h>

@interface GADYUMIViewController ()

@end

@implementation GADYUMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)handleAdmobTest:(UIButton *)sender {
    [GoogleMobileAdsMediationTestSuite presentWithAppID:@"ca-app-pub-9636835407493045~4230019358"
                                       onViewController:self
                                               delegate:nil];
}


@end
