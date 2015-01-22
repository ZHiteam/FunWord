//
//  FWKeyView.h
//  FunWord
//
//  Created by admin on 15-1-12.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKeyboardManager.h"

@interface FWKeyView : UICollectionViewCell
@property(nonatomic, readonly)NSString *keyValue;
- (void)setBackStyle:(FWBackStyle)backStyle;
- (void)setShowText:(NSString*)text;
+ (NSString *)reuseIdentifier;
@end
