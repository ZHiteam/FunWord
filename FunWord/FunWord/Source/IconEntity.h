//
//  IconEntity.h
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Catagory;

@interface IconEntity : NSManagedObject

@property (nonatomic, retain) NSString * iconId;
@property (nonatomic, retain) NSString * iconURL;
@property (nonatomic, retain) NSString * categoryId;
@property (nonatomic, retain) NSString * favorite;
@property (nonatomic, retain) Catagory *relationship;

@end
