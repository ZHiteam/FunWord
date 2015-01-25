//
//  FWHintView.h
//  FunWord
//
//  Created by admin on 15-1-24.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, FWHintViewType) {
    FWHintViewType1,
    FWHintViewType2,
    FWHintViewType3,
    FWHintViewType4
};

@interface FWHintView : UIView
+ (void)showInView:(UIView*)view style:(FWHintViewType)style point:(CGPoint)point  text:(NSString*)text;
+ (void)dismiss;
@end
