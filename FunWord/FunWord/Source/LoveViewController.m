//
//  LoveViewController.m
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "LoveViewController.h"
#import "FunWorkSegmentView.h"
#import "WordTableView.h"

@interface LoveViewController ()<FunWorkSegmentViewDelegate>
@property (nonatomic,assign) int32_t        type;
@property (nonatomic,strong) FunWorkSegmentView*    segment;
@property (nonatomic,strong) WordTableView* contentTable;
@end

@implementation LoveViewController

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.type = 1;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContent];
}

-(void)loadContent{
    self.navigationItem.title = @"Love";
    [self loadDefaultSetting];
    
    [self.view addSubview:self.segment];
    [self.view addSubview:self.contentTable];
    
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(FunWorkSegmentView *)segment{
    
    if (!_segment) {
        CGFloat top = self.navigationController.navigationBar.height+self.navigationController.navigationBar.y;
        _segment = [[FunWorkSegmentView alloc]initWithFrame:CGRectMake(0, top, self.view.width, 68)];
        [_segment loadSegmentAtIndex:0 image:[UIImage imageNamed:@"bt1_text_off"] selectImage:[UIImage imageNamed:@"bt1_text_on"]];
        [_segment loadSegmentAtIndex:1 image:[UIImage imageNamed:@"bt2_emotion_off"] selectImage:[UIImage imageNamed:@"bt2_emotion_on"]];
        [_segment setBGImage:[UIImage imageNamed:@"bt_bg"]];
        _segment.delegate = self;
    }
    
    return _segment;
}


#pragma -mark FunWorkSegmentViewDelegate
-(void)segmentSelectAt:(NSInteger)index{
    if (0 == index) {
        self.type = 1;
    }
    else{
        self.type = 2;
    }
    
//    [self reloadData];
}

-(WordTableView *)contentTable{
    
    if (!_contentTable) {
        CGFloat top = self.segment.height+self.segment.y;
        CGFloat height = self.view.height-top-self.tabBarController.tabBar.height;
        
        _contentTable = [[WordTableView alloc]initWithFrame:CGRectMake(0, top, self.view.width, height)];
    }
    
    return _contentTable;
}

#pragma -mark load data
-(void)request{

    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:2];
#warning test userId
    [dic setObject:@"1" forKey:@"userId"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"loadType"];
    
    
    [HttpClient requestDataWithPath:@"/api/font/getLoveFonts" paramers:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self praserData:responseObject];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)praserData:(NSDictionary*)data{
    NSArray* list = nil;
#warning 容错
    for (NSString* key in data.allKeys) {
        if ([key hasSuffix:@"favoriteRichWordList"]) {
            list = data[key];
            break;
        }
    }
    if(!list){
        list = data[@"favoriteRichWordList"];
    }

    
    NSMutableArray* ret = [[NSMutableArray alloc]initWithCapacity:list.count];
    
    for (NSDictionary* dic in list) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        WordModel* model = [WordModel praserModelWithInfo:dic];
        [ret addObject:model];
    }
    
    [self.contentTable reloadWithData:ret];
}

@end
