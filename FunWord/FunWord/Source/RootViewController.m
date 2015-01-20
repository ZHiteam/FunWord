//
//  RootViewController.m
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "RootViewController.h"
#import "RankingViewController.h"
#import "LoveViewController.h"
#import "EditViewController.h"

#import "GCTabbarItem.h"
#import "GCNavigationViewController.h"

#define BAR_BG_TAG  -1010
//// 隐藏 tabbar 上面的黑线
@interface UITabBar(Hide_Black_line)

@end

@implementation UITabBar(Hide_Black_line)

-(void)addSubview:(UIView *)view{
    [super addSubview:view];
    
    if ([self viewWithTag:BAR_BG_TAG] && view.tag != BAR_BG_TAG) {
        [self bringSubviewToFront:[self viewWithTag:BAR_BG_TAG]];
    }
}
@end

@interface RootViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) UIImageView* barView;
@property (nonatomic,strong) NSArray*   barItems;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self enterHome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enterHome{

    [self loadBarViewControllers];
    self.delegate = self;
}

-(void)loadBarViewControllers{
    GCNavigationViewController* bar1 = [[GCNavigationViewController alloc]initWithRootViewController:[[RankingViewController alloc]init]];
    GCNavigationViewController* bar2 = [[GCNavigationViewController alloc]initWithRootViewController:[[LoveViewController alloc]init]];
    GCNavigationViewController* bar3 = [[GCNavigationViewController alloc]initWithRootViewController:[[EditViewController alloc]init]];
    
    self.viewControllers = @[bar1,bar2,bar3];
    

    self.barView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, self.tabBar.width, self.tabBar.height+10)];
    self.barView.image = [UIImage imageNamed:@"actionbar_bg"];
    self.barView.tag = BAR_BG_TAG;
    [self.tabBar addSubview:self.barView];
    
    CGFloat xOffset = 0;
    CGFloat width = self.view.width/3;
    CGFloat span = (width-self.tabBar.height)/2;
    
    GCTabbarItem* item = [[GCTabbarItem alloc]initWithFrame:CGRectMake(xOffset+span, 10, self.tabBar.height, self.tabBar.height) image:[UIImage imageNamed:@"ranking_off"] selectedImage:[UIImage imageNamed:@"ranking_on"]];
    xOffset += width;
    item.selected = YES;
    [self.barView addSubview:item];

    GCTabbarItem* item2 = [[GCTabbarItem alloc]initWithFrame:CGRectMake(xOffset+span, 10, self.tabBar.height, self.tabBar.height) image:[UIImage imageNamed:@"love_off"] selectedImage:[UIImage imageNamed:@"love_on"]];
    xOffset += width;
    [self.barView addSubview:item2];

    GCTabbarItem* item3 = [[GCTabbarItem alloc]initWithFrame:CGRectMake(xOffset+span, 10, self.tabBar.height, self.tabBar.height) image:[UIImage imageNamed:@"edit_off"] selectedImage:[UIImage imageNamed:@"edit_on"]];
    xOffset += width;
    [self.barView addSubview:item3];
    
    self.barItems = @[item,item2,item3];
    
    self.tabBar.translucent = NO;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController*)viewController) popToRootViewControllerAnimated:YES];
    }
    
    if (index > self.barItems.count) {
        return;
    }
    
    for (NSUInteger i = 0; i < self.barItems.count; ++i) {
        GCTabbarItem* item = self.barItems[i];
        if (i == index) {
            [item setSelected:YES];
        }
        else{
            [item setSelected:NO];
        }
    }
}

@end
