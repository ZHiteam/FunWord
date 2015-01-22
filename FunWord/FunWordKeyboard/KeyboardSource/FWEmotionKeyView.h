//
//  FWEmotionKeyView.h
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKeyboardConst.h"
#import "FWKeyboardManager.h"

@interface FWEmotionKeyView : UICollectionViewCell
@property(nonatomic, strong)FWEmotionKeyboard *keyboard;
@property(nonatomic, copy)FWHandlerKeyBlock handleBlock;
+ (NSString *)reuseIdentifier;

@end
