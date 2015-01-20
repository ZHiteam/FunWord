//
//  WordCatagoryCell.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatagoryModel.h"

@interface WordCatagoryCell : UITableViewCell

-(instancetype)initWithWidth:(CGFloat)width reuseIdentifier:(NSString *)reuseIdentifier catagory:(CatagoryModel*)model another:(CatagoryModel*)another;

-(void)reloadCatagory:(CatagoryModel*)model another:(CatagoryModel*)another bgImage:(UIImage*)bgImage;

@end
