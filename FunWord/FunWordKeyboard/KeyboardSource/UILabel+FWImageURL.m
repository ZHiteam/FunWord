//
//  UILabel+FWImageURL.m
//  FunWord
//
//  Created by admin on 15-2-8.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "UILabel+FWImageURL.h"
#import <objc/runtime.h>
#import <objc/message.h>
static NSString * const FWImageURL   = @"FWImageURLKey";


@implementation UILabel (FWImageURL)
- (NSString*)imageURL{
    return objc_getAssociatedObject(self, ((__bridge void*)FWImageURL));
}

- (void)setImageURL:(NSString*)imageURL{
    if ([imageURL length] >0) {
        objc_setAssociatedObject(self, ((__bridge void*)FWImageURL), imageURL, OBJC_ASSOCIATION_RETAIN);
    }
}
@end
