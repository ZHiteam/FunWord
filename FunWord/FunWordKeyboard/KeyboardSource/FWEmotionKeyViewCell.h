//
//  FWEmotionKeyViewCell.h
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKeyboardConst.h"

@interface FWEmotionKeyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property(nonatomic, copy)FWHandlerKeyBlock handleBlock;
- (void)configureWithContents:(NSArray*)contents;
+ (float)height;

@end
