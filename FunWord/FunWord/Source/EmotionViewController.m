//
//  EmotionViewController.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EmotionViewController.h"
#import "FunWorkSegmentView.h"
#import "EmotionModel.h"
#import "EmotionCatagoryCell.h"

@interface EmotionViewController()<FunWorkSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>

//// 1：流行 2：最新
@property (nonatomic,assign) int32_t type;
@property (nonatomic,strong) FunWorkSegmentView*    segment;
@property (nonatomic,strong) UITableView*           contentTable;
@property (nonatomic,strong) EmotionModel*          data;
@end

@implementation EmotionViewController


-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.type = 1;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaultSetting];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emotion_bg1"]];
    
    [self.view addSubview:self.segment];
    
    [self.view addSubview:self.contentTable];
    
    [self reloadData];
}


-(FunWorkSegmentView *)segment{
    
    if (!_segment) {
        CGFloat top = self.navigationController.navigationBar.bottom;
        _segment = [[FunWorkSegmentView alloc]initWithFrame:CGRectMake(0, top, self.view.width, 68)];
        _segment.delegate = self;
    }
    
    return _segment;
}

-(UITableView *)contentTable{
    
    if (!_contentTable) {
        _contentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, self.segment.bottom, self.segment.width, self.view.height-self.segment.bottom-self.tabBarController.tabBar.height)];
        _contentTable.showsHorizontalScrollIndicator = NO;
        _contentTable.showsVerticalScrollIndicator = NO;
        _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTable.backgroundColor = [UIColor clearColor];
        _contentTable.delegate      = self;
        _contentTable.dataSource    = self;
    }
    
    return _contentTable;
}
#pragma -mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.childTitles.count/2+self.data.childTitles.count%2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify = @"emotionCell";
    EmotionCatagoryCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[EmotionCatagoryCell alloc]initWithWidth:tableView.width reuseIdentifier:identify catagory:nil another:nil];
    }
    
    if (indexPath.row < self.data.childTitles.count) {
        EmotionModel* model = self.data.childTitles[indexPath.row];
        EmotionModel* another = nil;
        if (indexPath.row+1 <  self.data.childTitles.count) {
            another = self.data.childTitles[indexPath.row+1];
        }
        
        [cell reloadCatagory:model another:another];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EmotionCatagoryCell cellHeight];
}

#pragma -mark load data

-(void)reloadData{
    if (1 ==  self.type) {
        self.navigationItem.title = @"流行的表情";
    }
    else{
        self.navigationItem.title = @"最新的表情";
    }
    
    NSDictionary* dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"loadType"];
    
    [HttpClient requestDataWithPath:@"/api/font/getIconCategory" paramers:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self praserData:responseObject];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)praserData:(NSDictionary* )data{
    
    NSDictionary* info = data[@"popularList"];
    if (!info) {
        info = data[@"richList"];
    }
    
    if (info) {
        self.data = [EmotionModel praserModelWithInfo:info];
    }
    [self.contentTable reloadData];
}

#pragma -mark FunWorkSegmentViewDelegate
-(void)segmentSelectAt:(NSInteger)index{
    if (0 == index) {
        self.type = 1;
    }
    else{
        self.type = 2;
    }
    
    [self reloadData];
}


@end
