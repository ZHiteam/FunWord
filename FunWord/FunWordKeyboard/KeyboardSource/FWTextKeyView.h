//
//  FWTextKeyView.h
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKeyboardManager.h"
#import "FWKeyboardConst.h"

@interface FWTextKeyView : UICollectionViewCell
@property(nonatomic, strong)FWTextKeyboard *keyboard;
@property(nonatomic, copy)FWHandlerKeyBlock handleBlock;

+ (NSString *)reuseIdentifier;

@end
