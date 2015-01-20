//
//  BaseModel.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VALIDATE_VALUE(val) [BaseModel validateStringValue:val]

@interface BaseModel : NSObject
@property (nonatomic) NSString* state;

+(id)praserModelWithInfo:(id)info;

+(NSString*)validateStringValue:(id)val;
@end
