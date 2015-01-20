//
//  CatagoryModel.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "CatagoryModel.h"

@implementation CatagoryModel

+(id)praserModelWithInfo:(id)info{
    CatagoryModel* model = [[CatagoryModel alloc]init];
    
    if (![info isKindOfClass:[NSDictionary class]]){
        return model;
    }
    NSDictionary* dic = (NSDictionary*)info;
    
    model.catagoryId    = VALIDATE_VALUE(dic[@"categoryId"]);
    model.modelId       = VALIDATE_VALUE(dic[@"id"]);
    model.name          = VALIDATE_VALUE(dic[@"name"]);
    
//    id val = dic[@"shortTitles"];
//    if ([val isKindOfClass:[NSArray class]]){
//        NSMutableArray* array = [[NSMutableArray alloc]initWithCapacity:((NSArray*)val).count];
//        for (id value in val){
//            SecondCatagoryModel* scModel = (SecondCatagoryModel*)[SecondCatagoryModel praserModelWithInfo:value];
//            [array addObject:scModel];
//        }
//        
//        model.productList = array;
//    }
    
    return model;
}


@end
