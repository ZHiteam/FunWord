//
//  WordEntity.h
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Catagory;

@interface WordEntity : NSManagedObject

@property (nonatomic, retain) NSString * wordId;
@property (nonatomic, retain) NSString * richWord;
@property (nonatomic, retain) NSString * catagoryId;
@property (nonatomic, retain) NSString * favorite;
@property (nonatomic, retain) Catagory *relationship;

@end
