//
//  WordCatagoryHeadCell.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordCatagoryHeadCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width;

-(void)setLabelTitle:(NSString*)labelTitle;
@end
