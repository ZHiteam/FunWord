//
//  FWTextKeyViewCell.m
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWTextKeyViewCell.h"
#import "UIView+FETouchBlocks.h"

@interface FWTextKeyViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *seperateLine1;
@property (weak, nonatomic) IBOutlet UIView *seperateLine2;
@property (weak, nonatomic) IBOutlet UIView *seperateLine3;
@property (weak, nonatomic) IBOutlet UILabel *textLebel1;
@property (weak, nonatomic) IBOutlet UILabel *textLabel2;
@property (weak, nonatomic) IBOutlet UILabel *textLabel3;
@property (weak, nonatomic) IBOutlet UILabel *textLabel4;

@end

@implementation FWTextKeyViewCell

- (void)awakeFromNib {
    // Initialization code
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    self.bottomLine.frame = CGRectMake(0, self.frame.size.height-0.5, width, 0.5);
    self.bottomLine.backgroundColor = [UIColor colorWithRed:158/255.0 green:129/255.0 blue:102/255.0 alpha:1.0];
    UIColor *color = [UIColor colorWithRed:174/255.0 green:150/255.0 blue:126/255.0 alpha:1.0];
    self.seperateLine1.backgroundColor = color;
    self.seperateLine2.backgroundColor = color;
    self.seperateLine3.backgroundColor = color;
    self.seperateLine1.frame = CGRectMake(roundf(width/4.0),   0, 0.5, self.frame.size.height);
    self.seperateLine2.frame = CGRectMake(roundf(width/4.0)*2, 0, 0.5, self.frame.size.height);
    self.seperateLine3.frame = CGRectMake(roundf(width/4.0)*3, 0, 0.5, self.frame.size.height);
    [self configureLabelSeleted:self.textLebel1];
    [self configureLabelSeleted:self.textLabel2];
    [self configureLabelSeleted:self.textLabel3];
    [self configureLabelSeleted:self.textLabel4];
    
    self.textLebel1.frame = CGRectMake(0, 0, roundf(width/4.0), self.frame.size.height);
    self.textLabel2.frame = CGRectMake(roundf(width/4.0), 0, roundf(width/4.0), self.frame.size.height);
    self.textLabel3.frame = CGRectMake(roundf(width/4.0)*2, 0, roundf(width/4.0), self.frame.size.height);
    self.textLabel4.frame = CGRectMake(roundf(width/4.0)*3, 0, roundf(width/4.0), self.frame.size.height);
    
    self.textLebel1.text = @"";
    self.textLabel2.text = @"";
    self.textLabel3.text = @"";
    self.textLabel4.text = @"";
}

- (void)configureWithContents:(NSArray*)contents{
    NSArray *labels = @[self.textLebel1,self.textLabel2,self.textLabel3,self.textLabel4];
    for (NSInteger index = 0; index < [contents count]; index++) {
        UILabel *label = [labels objectAtIndex:index];
        label.text = [contents objectAtIndex:index];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
                weakSelf.handleBlock(cell.text);
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
