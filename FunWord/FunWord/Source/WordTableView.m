//
//  WordTableView.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordTableView.h"
#import "WordCell.h"

@interface WordTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) NSArray*   data;

@end

@implementation WordTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.delegate      = self;
        self.dataSource    = self;
    }
    return self;
}

-(void)reloadWithData:(NSArray*)data{
    self.data = data;
    
    [self reloadData];
}

#pragma -mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identify = @"wordCell";
    
    WordCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[WordCell alloc]initWithWidth:tableView.width reuseIdentifier:identify];
    }
    
    [cell relaodWidthModel:self.data[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WordCell cellHeight];
}

@end
