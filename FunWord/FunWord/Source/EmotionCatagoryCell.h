//
//  EmotionCatagoryCell.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionModel.h"

@interface EmotionCatagoryCell : UITableViewCell

-(instancetype)initWithWidth:(CGFloat)width reuseIdentifier:(NSString *)reuseIdentifier catagory:(EmotionModel*)model another:(EmotionModel*)another;

-(void)reloadCatagory:(EmotionModel*)model another:(EmotionModel*)another;

+(CGFloat)cellHeight;

@end
