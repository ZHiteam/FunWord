//
//  FWKeyView.m
//  FunWord
//
//  Created by admin on 15-1-12.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "FWKeyView.h"
#import "FWKeyboardUtil.h"


@interface FWKeyView()
@property(nonatomic, strong)UILabel *textLabel;
@property(nonatomic, strong)UIImageView *backImageView;
@property(nonatomic, strong)UIView      *highlightedView;
@property(nonatomic, strong)NSString    *imageNameN;
@property(nonatomic, strong)NSString    *imageNameH;
@end

@implementation FWKeyView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.textLabel];
        self.backgroundView = self.backImageView;
        [self.contentView addSubview:self.highlightedView];
    }
    return self;
}

- (void)setBackStyle:(FWBackStyle)backStyle{
    NSString *imageName = nil;
    switch (backStyle) {
        case FWBackStyle1:
            imageName = @"key_bg1";
            break;
        case FWBackStyle2:
            imageName = @"key_bg2";
            break;
        case FWBackStyle3:
            imageName = @"key_bg3";
            break;
        default:
            break;
    }
    self.imageNameN = imageName;
    self.imageNameH = [imageName stringByAppendingString:@"_pressed"];
    self.backImageView.image = [UIImage imageNamed:imageName];
}

- (void)setShowText:(NSString*)text{
    self.textLabel.text = nil;
    _keyValue = text;
    if ([text hasPrefix:@"F"]) {
        text = [FWKeyboardUtil mapWithKeyValue:text];
    }
    UIImage *image = [UIImage imageNamed:text];
    if (image) {
        self.imageNameN = text;
        self.imageNameH = [text stringByAppendingString:@"_pressed"];
        self.backImageView.image = image;
    } else {
        self.textLabel.text = text;
    }
}

+ (NSString *)reuseIdentifier{
    return @"FWKeyViewCellId";
}

#pragma mark - Privte Method
- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor colorWithRed:109/255.0 green:60/255.0 blue:0/255.0 alpha:1.0];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIImageView *)backImageView{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.contentMode = UIViewContentModeCenter;
    }
    return _backImageView;
}

- (UIView *)highlightedView{
    if (_highlightedView == nil) {
        _highlightedView = [[UIView alloc] initWithFrame: CGRectInset( self.bounds, 6, 6)];
        _highlightedView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        _highlightedView.hidden = YES;
    }
    return _highlightedView;
}

- (void)setHighlighted:(BOOL)highlighted{
    //self.highlightedView.hidden = !highlighted;
    if (highlighted) {
        self.backImageView.image = [UIImage imageNamed:self.imageNameH];
    } else {
        self.backImageView.image = [UIImage imageNamed:self.imageNameN];
    }
}

#pragma mark - Override
- (void)layoutSubviews{
    self.textLabel.frame = self.bounds;
    self.backImageView.frame = self.bounds;
    self.highlightedView.frame = self.bounds;
}

@end
