//
//  FWSecondVC.m
//  FunWord
//
//  Created by admin on 14-12-30.
//  Copyright (c) 2014年 funword. All rights reserved.
//

#import "FWSecondVC.h"

@interface FWSecondVC ()

@end

@implementation FWSecondVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        FETabBarButton *button = [FETabBarButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"FirstN"]  forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"FirstS"]  forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"FirstS"]  forState:UIControlStateHighlighted];
        
        [button setTitle:@"首页" forState:UIControlStateNormal];
        [button setTitle:@"首页" forState:UIControlStateSelected];
        [button setTitleColor:FERGB(0x87, 0x8b, 0x91, 1.0) forState:UIControlStateNormal];
        [button setTitleColor:FERGB(0x2e, 0x39, 0x48, 1.0) forState:UIControlStateSelected];
        [button setTitleColor:FERGB(0x2e, 0x39, 0x48, 1.0) forState:UIControlStateHighlighted];
        self.tabBarItem.FECustomView = button;
        self.title = @"首页";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
