//
//  GCNavigationViewController.m
//  ExpressBrother
//
//  Created by elvis on 15/1/12.
//  Copyright (c) 2015年 GCloud. All rights reserved.
//

#import "GCNavigationViewController.h"

@interface GCNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation GCNavigationViewController

-(instancetype)init{
    
    self  =[super init];
    if (self) {
        [self gc_initLoads];
    }
    
    return self;
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self gc_initLoads];
    }
    return self;
}

-(void)gc_initLoads{
    [self enableEffect];
    self.delegate = self;
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor whiteColor], UITextAttributeTextColor,
                                                [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                [UIFont systemFontOfSize:18], UITextAttributeFont,
                                                                     nil]];
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    NSArray *list= self.navigationBar.subviews;
    
    for (id obj in list) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView=(UIImageView *)obj;
            imageView.hidden=YES;
        }
    }
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
    
    imageView.image=[UIImage imageNamed:@"topbar_bg"];
    
    [self.navigationBar addSubview:imageView];
    [self.navigationBar sendSubviewToBack:imageView];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma -mark
#pragma -mark NavigationBar effects
-(void)enableEffect{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationBar.tintColor = FERGB(255, 100, 0,1);
    } else {
        // Load resources for iOS 7 or later
        self.navigationBar.barTintColor = FERGB(255, 100, 0,1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end