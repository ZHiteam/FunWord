//
//  EmotionCatagoryCell.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EmotionCatagoryCell.h"
#import "EmotionCatagoryView.h"

@interface EmotionCatagoryCell()

@property (nonatomic,strong) EmotionCatagoryView*  btn1;
@property (nonatomic,strong) EmotionCatagoryView*  btn2;

@end

@implementation EmotionCatagoryCell

+(CGFloat)cellHeight{
//    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
//    width = (width-20-16-20)/2;
//    
//    return width+40+10;
    return 200;
}

-(instancetype)initWithWidth:(CGFloat)width reuseIdentifier:(NSString *)reuseIdentifier catagory:(EmotionModel*)model another:(EmotionModel*)another{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = width;
        
        [self.contentView addSubview:self.btn1];
        if (another) {
            [self.contentView addSubview:self.btn2];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self reloadCatagory:model another:another];

    }
    return self;
}

-(EmotionCatagoryView *)btn1{
    
    if (!_btn1) {
        CGFloat span = (self.width/2 -140)/2;
        _btn1 = [[EmotionCatagoryView alloc]initWithFrame:CGRectMake(span, 10, 140, 180)];
    }
    
    return _btn1;
}

-(EmotionCatagoryView *)btn2{
    
    if (!_btn2) {
        CGFloat span = (self.width/2 -140)/2;
        _btn2 = [[EmotionCatagoryView alloc]initWithFrame:CGRectMake(self.width/2+span, 10, 140, 180)];
    }
    
    return _btn2;
}

-(void)reloadCatagory:(EmotionModel*)model another:(EmotionModel*)another{
    [self.btn1 reloadWithModel:model];
    if (another) {
        [self.btn2 reloadWithModel:another];
        [self.contentView addSubview:self.btn2];
    }
    else if (!self.btn2.superview){
        [self.btn2 removeFromSuperview];
    }

}


@end
