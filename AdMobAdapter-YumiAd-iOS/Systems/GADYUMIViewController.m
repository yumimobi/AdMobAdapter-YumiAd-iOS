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
    [GoogleMobileAdsMediationTestSuite presentWithAppID:@"ca-app-pub-9454875840803246~2667523573"
                                       onViewController:self
                                               delegate:nil];
}


@end
