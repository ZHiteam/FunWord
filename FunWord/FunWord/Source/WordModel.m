//
//  WordModel.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordModel.h"

@implementation WordModel

+(id)praserModelWithInfo:(id)info{
    WordModel* model = [[WordModel alloc]init];
    
    if (![info isKindOfClass:[NSDictionary class]]){
        return model;
    }
    NSDictionary* dic = (NSDictionary*)info;
    
    model.catagoryId    = VALIDATE_VALUE(dic[@"categoryId"]);
    model.favorite      = VALIDATE_VALUE(dic[@"favorite"]);
    model.richWord      = VALIDATE_VALUE(dic[@"richWord"]);
    model.wordId        = VALIDATE_VALUE(dic[@"wordId"]);
    model.c_id          = VALIDATE_VALUE(dic[@"id"]);
    
    return model;
}

@end
