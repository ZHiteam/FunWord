//
//  WordCatagoryModel.m
//  FunWord
//
//  Created by elvis on 15/1/23.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordCatagoryModel.h"

@implementation WordCatagoryModel

+(id)praserModelWithInfo:(id)info{
    
    WordCatagoryModel* model = [[WordCatagoryModel alloc]init];
    
    if (![info isKindOfClass:[NSDictionary class]]){
        return model;
    }
    NSDictionary* dic = (NSDictionary*)info;
    
    model.catagoryId    = VALIDATE_VALUE(dic[@"categoryId"]);
    model.modelId       = VALIDATE_VALUE(dic[@"id"]);
    model.name          = VALIDATE_VALUE(dic[@"name"]);
    
    NSArray* data = dic[@"childTitles"];
    if (data) {
        NSMutableArray* arry = [[NSMutableArray alloc]initWithCapacity:data.count];
        for (int i = 0; i < data.count; ++i) {
            NSDictionary* childDic = data[i];
            if (![childDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }

            WordCatagoryModel* child = [WordCatagoryModel praserModelWithInfo:childDic];
            [arry addObject:child];
         
        }
        model.childTitles = arry;
        
    }
    

    
    return model;
}


@end
