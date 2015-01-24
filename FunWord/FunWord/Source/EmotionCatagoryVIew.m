//
//  EmotionCatagoryVIew.m
//  FunWord
//
//  Created by elvis on 15/1/23.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EmotionCatagoryView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EmotionCatagoryView()
@property (nonatomic,strong) EmotionModel*  model;

@property (nonatomic,strong) UIImageView*   bgView;
@property (nonatomic,strong) UIImageView*   photoView;
@property (nonatomic,strong) UILabel*       labelView;
@end

@implementation EmotionCatagoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.bgView];
        [self addSubview:self.photoView];
        [self addSubview:self.labelView];
    }
    return self;
}

-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _bgView.image = [UIImage imageNamed:@"emotion1"];
    }
    return _bgView;
}

-(UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, self.bgView.width-60, self.bgView.height-60)];
        _photoView.backgroundColor = [UIColor clearColor];
        _photoView.clipsToBounds = YES;
    }
    return _photoView;
}

-(UILabel *)labelView{
    if (!_labelView) {
        _labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgView.height, self.bgView.width, self.height-self.bgView.height)];
        _labelView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emotion_title_bg"]];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = FERGB(0x8d, 0x59, 0x36, 1);
        _labelView.font = SYS_FONT(12);
    }
    return _labelView;
}

-(void)reloadWithModel:(EmotionModel *)model{
    self.model = model;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl]];
    self.labelView.text = model.name;
}

@end
