//
//  EmotionCatagoryVIew.h
//  FunWord
//
//  Created by elvis on 15/1/23.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionModel.h"

@interface EmotionCatagoryView : UIView
-(void)reloadWithModel:(EmotionModel*)model;
@end
