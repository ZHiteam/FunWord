//
//  FWHintView.m
//  FunWord
//
//  Created by admin on 15-1-24.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "FWHintView.h"

@interface FWHintView ()
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *textLabel;
@property(nonatomic, assign)FWHintViewType type;
@end

static   FWHintView *hintView = nil;

@implementation FWHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
    }
    return self;
}

+ (void)showInView:(UIView*)view style:(FWHintViewType)style point:(CGPoint)point  text:(NSString*)text{
    if (view && [text length] >0) {
        //self.textLabel.text = text;
        CGSize size = [self getSizeWithType:style];
        CGFloat orignX = MAX(0, point.x-size.width/2.0);
        CGFloat orignY = point.y - size.height;
        hintView = [[FWHintView alloc] initWithFrame:CGRectMake(orignX, orignY, size.width, size.height)];
        hintView.textLabel.text = text;
        hintView.type = style;
        [view addSubview:hintView];
    }
}

+ (void)dismiss{
    [hintView removeFromSuperview];
    hintView = nil;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor colorWithRed:109/255.0 green:60/255.0 blue:0/255.0 alpha:1.0];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:20];
    }
    return _textLabel;
}

-(void)setType:(FWHintViewType)type{
    _type = type;
    NSString *imageName = nil;
    switch (type) {
        case FWHintViewType1:
            imageName = @"key_bg1_pressed1";
            break;
        case FWHintViewType2:
            imageName = @"key_bg1_pressed2";
            break;
        case FWHintViewType3:
            imageName = @"key_bg1_pressed3";
            break;
        case FWHintViewType4:
            imageName = @"key_bg1_pressed4";
            break;
        default:
            break;
    }
    self.imageView.image = [UIImage imageNamed:imageName];
}


+ (CGSize)getSizeWithType:(FWHintViewType)type{
    CGSize size = CGSizeZero;
    switch (type) {
        case FWHintViewType1:
            size = CGSizeMake(73, 108);
            break;
        case FWHintViewType2:
            size = CGSizeMake(65, 108);
            break;
        case FWHintViewType3:
            size = CGSizeMake(65, 108);
            break;
        case FWHintViewType4:
            size = CGSizeMake(85, 108);
            break;
        default:
            break;
    }
    return size;
}

@end
