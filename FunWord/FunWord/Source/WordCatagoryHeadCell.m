//
//  WordCatagoryHeadCell.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordCatagoryHeadCell.h"

@interface WordCatagoryHeadCell()
@property (nonatomic,strong) UILabel*   label;

@end

@implementation WordCatagoryHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = width;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView* image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.width, 50)];
        image.contentMode = UIViewContentModeCenter;
        image.image = [UIImage imageNamed:@"word_bg"];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, image.width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = FERGB(248, 248, 248, 1);
        label.font = FONT(20);
        
        label.textAlignment = NSTextAlignmentCenter;
        [image addSubview:label];
        self.label = label;
        
        [self.contentView addSubview:image];
    }
    
    return self;
}

-(void)setLabelTitle:(NSString *)labelTitle{
    self.label.text = labelTitle;
}

@end
