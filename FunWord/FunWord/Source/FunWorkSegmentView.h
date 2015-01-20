//
//  SegmentView.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunWorkSegmentViewDelegate <NSObject>

-(void)segmentSelectAt:(NSInteger)index;

@end

@interface FunWorkSegmentView : UIView

-(void)loadSegmentAtIndex:(NSInteger)index image:(UIImage*)image selectImage:(UIImage*)selectImage;
-(void)setBGImage:(UIImage*)image;

@property (nonatomic,weak) id<FunWorkSegmentViewDelegate> delegate;

@end
