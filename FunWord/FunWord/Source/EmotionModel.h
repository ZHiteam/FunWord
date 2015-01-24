//
//  EmotionModel.h
//  FunWord
//
//  Created by elvis on 15/1/23.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "BaseModel.h"

@interface EmotionModel : BaseModel

@property (nonatomic,strong) NSString * catagoryId;
@property (nonatomic,strong) NSString * modelId;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * photoUrl;
@property (nonatomic,strong) NSArray * childTitles;
@end
