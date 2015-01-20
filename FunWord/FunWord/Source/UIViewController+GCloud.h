//
//  UIViewController+GCloud.h
//  ExpressBrother
//
//  Created by elvis on 15/1/13.
//  Copyright (c) 2015年 GCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GCloud)

-(UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target selector:(SEL)selector;

-(UIBarButtonItem*)backBarButtonWithTarget:(id)target selector:(SEL)selector;

-(UIBarButtonItem*)backBarButton;

-(void)loadDefaultSetting;

-(void)userAction;

@end
