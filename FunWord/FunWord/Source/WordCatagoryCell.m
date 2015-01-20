//
//  WordCatagoryCell.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordCatagoryCell.h"

#define BTN_WIDTH   124
#define BTN_SPAN    18

@interface WordCatagoryCell()

@property (nonatomic,strong) UIButton*  btn1;
@property (nonatomic,strong) UIButton*  btn2;

@property (nonatomic,strong) CatagoryModel* model1;
@property (nonatomic,strong) CatagoryModel* model2;
@end

@implementation WordCatagoryCell

-(instancetype)initWithWidth:(CGFloat)width reuseIdentifier:(NSString *)reuseIdentifier catagory:(CatagoryModel *)model another:(CatagoryModel *)another{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.width = width;
        
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self reloadCatagory:model another:another bgImage:nil];
    }
    
    return self;
}

-(UIButton *)btn1{
    if (!_btn1) {
        CGFloat span = (self.width-BTN_WIDTH*2-BTN_SPAN)/2;
        _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(span, 10, BTN_WIDTH, 40)];
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"text_bt_bg1"] forState:UIControlStateNormal];
        [_btn1 setTitleColor:FERGB(0x8d, 0x59, 0x36, 1) forState:UIControlStateNormal];
        _btn1.titleLabel.font = SYS_FONT(16);
        [_btn1 addTarget:self action:@selector(dealPush:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btn1;
}

-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.btn1.width+self.btn1.x+BTN_SPAN, 10, BTN_WIDTH, 40)];
        [_btn2 setBackgroundImage:[UIImage imageNamed:@"text_bt_bg1"] forState:UIControlStateNormal];
        [_btn2 setTitleColor:FERGB(0x8d, 0x59, 0x36, 1) forState:UIControlStateNormal];
        _btn2.titleLabel.font = SYS_FONT(16);
        [_btn2 addTarget:self action:@selector(dealPush:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    return _btn2;
}

-(void)reloadCatagory:(CatagoryModel *)model another:(CatagoryModel *)another bgImage:(UIImage *)bgImage{
    self.model1 = model;
    self.model2 = another;
    
    [self.btn1 setTitle:self.model1.name forState:UIControlStateNormal];
    [self.btn2 setTitle:self.model2.name forState:UIControlStateNormal];
    
    if (bgImage){
        [self.btn1 setBackgroundImage:bgImage forState:UIControlStateNormal];
        [self.btn2 setBackgroundImage:bgImage forState:UIControlStateNormal];
    }
}

-(void)dealPush:(UIButton*)btn{
    NSDictionary* dic = nil;
    if (btn == self.btn1) {
        dic = @{@"ctl":@"WordCagatoryViewController",
                @"info":self.model1};
    }
    else if (btn == self.btn2){
        dic = @{@"ctl":@"WordCagatoryViewController",
                @"info":self.model2};
    }
    
    if (dic) {
        [[NSNotificationCenter defaultCenter]postNotificationName:PUSH_NOTIFACTION object:dic];
    }
}

@end
