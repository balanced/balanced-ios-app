//
//  SidebarViewController.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAPage.h"
#import "AppDelegate.h"
#import "SidebarViewController.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    __typeof(self) __weak weakSelf = self;
    [app.model.marketplaceUpdatedEvent subscribeObserver:^(BAMarketplace *marketplace) {
        [weakSelf updateMarketplace];
    }];
    [self updateMarketplace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMarketplace {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!app.model.currentMarketplace) {
        return;
    }
    self.marketplaceLabel.text = app.model.currentMarketplace.name;
    self.balanceLabel.text = [NSString stringWithFormat:@"Balance: %.2f", app.model.currentMarketplace.balance / 100.0];
    // XXX:
    BAPage *debits = app.model.currentMarketplace.resources[@"debits"];
    [debits loadNextPage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
