//
//  WordViewController.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordViewController.h"
#import "FunWorkSegmentView.h"
#import "WordCatagoryCell.h"
#import "WordCatagoryHeadCell.h"

@interface WordViewController()<FunWorkSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>

//// 1：流行 2：最新
@property (nonatomic,assign) int32_t type;
@property (nonatomic,strong) FunWorkSegmentView*    segment;
@property (nonatomic,strong) UITableView*           contentTable;
@property (nonatomic,strong) NSArray*               data;
@end

@implementation WordViewController

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
        _contentTable.delegate      = self;
        _contentTable.dataSource    = self;
    }
    
    return _contentTable;
}

#pragma -mark load data

-(void)reloadData{
    if (1 ==  self.type) {
        self.navigationItem.title = @"流行的颜文字";
    }
    else{
        self.navigationItem.title = @"最新的颜文字";
    }
    
    NSDictionary* dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"loadType"];
    
    [HttpClient requestDataWithPath:@"/api/font/getWordCategory" paramers:dic success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [self praserData:responseObject];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)praserData:(NSDictionary* )data{
    self.data = @[@"开心",@"滑稽"];
    [self.contentTable reloadData];
}

#pragma -mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
#warning TEST
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = nil;
    if (0 == indexPath.row) {
        static NSString* headIdentifier = @"head";
        WordCatagoryHeadCell* head = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
        if (!head) {
            head = [[WordCatagoryHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headIdentifier width:tableView.width];
        }
        
        [head setLabelTitle:self.data[indexPath.section]];
        
        cell = head;
    }
    else{
        static NSString* reuseIdentifier = @"wordCatagoryCell";
        WordCatagoryCell* word = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!word) {
            word = [[WordCatagoryCell alloc]initWithWidth:tableView.width reuseIdentifier:reuseIdentifier catagory:nil another:nil];
            word.backgroundColor = [UIColor clearColor];
        }
        
        NSString* bgImage = @"text_bt_bg1";
        if (indexPath.section%2) {
            bgImage = @"text_bt_bg2";
        }
        
        CatagoryModel* model = [[CatagoryModel alloc]init];
        model.name = @"兴奋";
        model.catagoryId = @"7";
        model.loadType = [NSString stringWithFormat:@"%d",self.type];
        
        [word reloadCatagory:model another:model bgImage:[UIImage imageNamed:bgImage]];
        
        cell = word;
    }
    
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == self.data.count-1) {
        return nil;
    }
    
    UIImageView* image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.height, 24)];
    image.image = [UIImage imageNamed:@"rose_line"];
    return image;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.data.count -1) {
        return 0;
    }
    return 24;
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
