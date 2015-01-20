//
//  SegmentView.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "FunWorkSegmentView.h"

@interface FunWorkSegmentView()

@property (nonatomic,strong) UIButton* popularBtn;
@property (nonatomic,strong) UIButton* newestBtn;

@end

@implementation FunWorkSegmentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self reloadData];
    }
    
    return self;
}

-(void)reloadData{
    
    [self setBGImage:[UIImage imageNamed:@"emotion_bt_bg"]];
    
    CGFloat width = 104;
    CGFloat span = 16;
    
    CGFloat leftSpan = (self.width-width*2-span)/2;
    
    UIButton* lx = [[UIButton alloc]initWithFrame:CGRectMake(leftSpan, 7, width, 48)];
    [lx setImage:[UIImage imageNamed:@"bt_popular_off"] forState:UIControlStateNormal];
    [lx setImage:[UIImage imageNamed:@"bt_popular_on"] forState:UIControlStateHighlighted];
    [lx setImage:[UIImage imageNamed:@"bt_popular_on"] forState:UIControlStateSelected];
    [lx addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:lx];
    self.popularBtn = lx;
    
    UIButton* xin = [[UIButton alloc]initWithFrame:CGRectMake(leftSpan+span+width, 7, width, 48)];
    [xin setImage:[UIImage imageNamed:@"bt_new_off"] forState:UIControlStateNormal];
    [xin setImage:[UIImage imageNamed:@"bt_new_on"] forState:UIControlStateHighlighted];
    [xin setImage:[UIImage imageNamed:@"bt_new_on"] forState:UIControlStateSelected];
    [xin addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:xin];
    self.newestBtn = xin;
    
    self.popularBtn.selected = YES;
}

-(void)setBGImage:(UIImage *)image{
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)loadSegmentAtIndex:(NSInteger)index image:(UIImage *)image selectImage:(UIImage *)selectImage{
    UIButton* segBtn = nil;
    if (0 == index) {
        segBtn = self.popularBtn;
    }
    else{
        segBtn = self.newestBtn;
    }
    
    if (!segBtn) {
        return;
    }
    
    [segBtn setImage:image forState:UIControlStateNormal];
    [segBtn setImage:selectImage forState:UIControlStateHighlighted];
    [segBtn setImage:selectImage forState:UIControlStateSelected];
}

-(void)segmentAction:(id)sender{
    if (sender == self.popularBtn) {
        self.newestBtn.selected = NO;
        self.popularBtn.selected = YES;
        
        if ([self.delegate respondsToSelector:@selector(segmentSelectAt:)]) {
            [self.delegate segmentSelectAt:0];
        }
    }
    else{
        self.newestBtn.selected = YES;
        self.popularBtn.selected = NO;
        
        if ([self.delegate respondsToSelector:@selector(segmentSelectAt:)]) {
            [self.delegate segmentSelectAt:1];
        }
    }
}

@end
