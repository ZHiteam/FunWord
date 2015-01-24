//
//  EmotionModel.m
//  FunWord
//
//  Created by elvis on 15/1/23.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EmotionModel.h"

@implementation EmotionModel

+(id)praserModelWithInfo:(id)info{
    
    EmotionModel* model = [[EmotionModel alloc]init];
    
    if (![info isKindOfClass:[NSDictionary class]]){
        return model;
    }
    NSDictionary* dic = (NSDictionary*)info;
    
    model.catagoryId    = VALIDATE_VALUE(dic[@"categoryId"]);
    model.modelId       = VALIDATE_VALUE(dic[@"id"]);
    model.name          = VALIDATE_VALUE(dic[@"name"]);
    model.photoUrl      = VALIDATE_VALUE(dic[@"photo_url"]);
    
    NSArray* data = dic[@"childTitles"];
    if (data) {
        NSMutableArray* arry = [[NSMutableArray alloc]initWithCapacity:data.count];
        for (int i = 0; i < data.count; ++i) {
            NSDictionary* childDic = data[i];
            if (![childDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            EmotionModel* child = [EmotionModel praserModelWithInfo:childDic];
            [arry addObject:child];
            
        }
        model.childTitles = arry;
        
    }
    
    
    
    return model;
}


@end
