//
//  BaseModel.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(id)praserModelWithInfo:(id)info{
    BaseModel* model = [[BaseModel alloc]init];
    if (! [info isKindOfClass:[NSDictionary class]]){
        return model;
    }
    
    NSDictionary* dic = (NSDictionary*)info;
    model.state = VALIDATE_VALUE(dic[@"result"]);
    
    return model;
}

+(NSString *)validateStringValue:(id)val{
    if ([val isKindOfClass:[NSNull class]]){
        return @"";
    }
    
    if ([val isKindOfClass:[NSString class]]){
        return val;
    }
    
    if ([val isKindOfClass:[NSNumber class]]){
        return [val descriptionWithLocale:nil];
    }
    
    return @"";
}
@end
