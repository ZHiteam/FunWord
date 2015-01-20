//
//  WordTableView.h
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordModel.h"

@interface WordTableView : UITableView
-(void)reloadWithData:(NSArray*)data;

@end
