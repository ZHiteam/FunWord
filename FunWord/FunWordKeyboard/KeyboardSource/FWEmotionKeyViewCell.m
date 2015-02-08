//
//  FWEmotionKeyViewCell.m
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWEmotionKeyViewCell.h"
#import "UIView+FETouchBlocks.h"
#import "UILabel+FWImageURL.h"

@interface FWEmotionKeyViewCell ()

@end

@implementation FWEmotionKeyViewCell

- (void)awakeFromNib {
    // Initialization code
    UIColor *color = [UIColor colorWithRed:117/255.0 green:79/255.0 blue:46/255.0 alpha:1.0];
    self.label1.textColor = color;
    self.label2.textColor = color;
    self.label3.textColor = color;
    self.label4.textColor = color;
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    self.imageView1.frame = CGRectMake(8, 8, roundf(width/4.0)-16, 56);
    self.label1.frame = CGRectMake(0, 64, roundf(width/4.0), 14);
    self.imageView2.frame = CGRectMake(roundf(width/4.0)+8, 8, roundf(width/4.0)-16, 56);
    self.label2.frame = CGRectMake(roundf(width/4.0), 64, roundf(width/4.0), 14);
    self.imageView3.frame = CGRectMake(roundf(width/4.0)*2+8, 8, roundf(width/4.0)-16, 56);
    self.label3.frame = CGRectMake(roundf(width/4.0)*2, 64, roundf(width/4.0), 14);
    self.imageView4.frame = CGRectMake(roundf(width/4.0)*3+8, 8, roundf(width/4.0)-16, 56);
    self.label4.frame = CGRectMake(roundf(width/4.0)*3, 64, roundf(width/4.0), 14);
    
    [self configureLabelSeleted:self.label1];
    [self configureLabelSeleted:self.label2];
    [self configureLabelSeleted:self.label3];
    [self configureLabelSeleted:self.label4];
    
    self.label1.text = @"";
    self.label2.text = @"";
    self.label3.text = @"";
    self.label4.text = @"";
    self.imageView1.image = nil;
    self.imageView2.image = nil;
    self.imageView3.image = nil;
    self.imageView4.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (float)height{
    return 80.0;
}

- (void)configureWithContents:(NSArray*)contents{
    NSArray *labels = @[self.label1,self.label2,self.label3,self.label4];
    for (NSInteger index = 0; index < [contents count]; index++) {
        UILabel *label = [labels objectAtIndex:index];
        label.text = [contents objectAtIndex:index];
    }
    __weak typeof(self) weakSelf = self;
    [self.imageView1 touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(self.label1.imageURL);
        }
    }];
    [self.imageView2 touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(self.label2.imageURL);
        }
    }];
    [self.imageView3 touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(self.label3.imageURL);
        }
    }];
    [self.imageView4 touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(self.label4.imageURL);
        }
    }];
}

- (void)configureLabelSeleted:(UILabel*)label{
    __weak UILabel *cell = label;
    __weak typeof(self) weakSelf = self;
    [label touchBeganBlock:^(NSSet *touches, UIEvent *event) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }];
    
    [label touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.backgroundColor = [UIColor clearColor];
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(cell.imageURL);
            }
        });
    }];
    
    [label touchCancelledBlock:^(NSSet *touches, UIEvent *event) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.backgroundColor = [UIColor clearColor];
        });
    }];
}

@end
