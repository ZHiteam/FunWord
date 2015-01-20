//
//  UIViewController+GCloud.m
//  ExpressBrother
//
//  Created by elvis on 15/1/13.
//  Copyright (c) 2015年 GCloud. All rights reserved.
//

#import "UIViewController+GCloud.h"
#import <objc/runtime.h>
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialAccountManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

static const void* userInfoKey = &userInfoKey;

@implementation UIViewController (GCloud)

@dynamic userInfo;

-(void)setUserInfo:(id)userInfo{
    objc_setAssociatedObject(self, userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN);
}

-(id)userInfo{
    return objc_getAssociatedObject(self, userInfoKey);
}

-(UIBarButtonItem *)barItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector{
    
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return item;
}

-(UIBarButtonItem*)backBarButtonWithTarget:(id)target selector:(SEL)selector{
    CGFloat height = self.navigationController.navigationBar.height;
    UIImage* image = [UIImage imageNamed:@"topbar_bt_back"];
    
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* back =[[UIBarButtonItem alloc]initWithCustomView:button];
    return back;

}

-(UIBarButtonItem*)backBarButton{
    return [self backBarButtonWithTarget:self selector:@selector(gc_pop)];
}

-(void)gc_pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadDefaultSetting{
    
    NSDictionary* info = [[NSUserDefaults standardUserDefaults]valueForKey:@"SSO"];
    if (info) {
        [self updateUserInfo:info];
    }
    else{
        self.navigationItem.rightBarButtonItem = [self barItemWithImage:[UIImage imageNamed:@"topbar_bt_user"] target:self selector:@selector(userAction)];        
    }
    
    if (self.navigationController.viewControllers.firstObject != self) {
        self.navigationItem.leftBarButtonItem = [self backBarButton];
    }

}

-(void)userAction{
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"SSO"]) {
        return;
    }
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSMutableDictionary* info = [[NSMutableDictionary alloc]initWithCapacity:3];
            if (snsAccount.userName) {
                [info setObject:snsAccount.userName forKey:@"name"];
            }
            if (snsAccount.usid) {
                [info setObject:snsAccount.usid forKey:@"usid"];
            }
            if (snsAccount.accessToken) {
                [info setObject:snsAccount.accessToken forKey:@"token"];
            }
            if (snsAccount.iconURL) {
                [info setObject:snsAccount.iconURL forKey:@"icon"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:info forKey:@"SSO"];
            
            [self updateUserInfo:info];
        }
        else{
        }
        
//        [alert show];
    });
}

-(void)updateUserInfo:(NSDictionary*)info{
    if (!info[@"name"]) {
        return;
    }
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 32, 32)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:info[@"icon"]]];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 16;

    UIImageView* bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 34, 34)];
    bgImage.image = [UIImage imageNamed:@"user_bg"];
    
    UIControl* ctl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [ctl addSubview:bgImage];
    [ctl addSubview:imageView];
    
    [ctl addTarget:self action:@selector(userInfoAction) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:ctl];
}

-(void)userInfoAction{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"SSO"];
    [self loadDefaultSetting];
}
@end

@interface UINavigationItem (margin)

@end

@implementation UINavigationItem (margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
        
        
    }
    else
    {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
        
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
        
    }
    else
    {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

#endif
@end