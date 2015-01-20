//
//  EmotionViewController.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EmotionViewController.h"
#import "FunWorkSegmentView.h"

@interface EmotionViewController()<FunWorkSegmentViewDelegate>

//// 1：流行 2：最新
@property (nonatomic,assign) int32_t type;
@property (nonatomic,strong) FunWorkSegmentView*    segment;
@property (nonatomic,strong) UITableView*           contentTable;
@end

@implementation EmotionViewController


-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.type = 1;
    }
    
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadDefaultSetting];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emotion_bg1"]];
    
    [self.view addSubview:self.segment];
    
    [self.view addSubview:self.contentTable];
    
    [self reloadData];
}


-(FunWorkSegmentView *)segment{
    
    if (!_segment) {
        CGFloat top = self.navigationController.navigationBar.height+self.navigationController.navigationBar.y;
        _segment = [[FunWorkSegmentView alloc]initWithFrame:CGRectMake(0, top, self.view.width, 68)];
        _segment.delegate = self;
    }
    
    return _segment;
}

-(UITableView *)contentTable{
    
    if (!_contentTable) {
        _contentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, self.segment.height+self.segment.y, self.segment.width, self.view.height-self.segment.height-self.segment.y-self.tabBarController.tabBar.height)];
        _contentTable.showsHorizontalScrollIndicator = NO;
        _contentTable.showsVerticalScrollIndicator = NO;
        _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTable.backgroundColor = [UIColor clearColor];
//        _contentTable.delegate      = self;
//        _contentTable.dataSource    = self;
    }
    
    return _contentTable;
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
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)praserData:(NSDictionary* )data{
    
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
