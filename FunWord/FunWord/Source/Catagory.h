//
//  Catagory.h
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Catagory : NSManagedObject

@property (nonatomic, retain) NSString * catagoryId;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parentId;

@end
