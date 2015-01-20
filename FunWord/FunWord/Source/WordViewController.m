//
//  WordViewController.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordViewController.h"
#import "FunWorkSegmentView.h"

@interface WordViewController()<FunWorkSegmentViewDelegate>

@property (nonatomic,strong) FunWorkSegmentView*    segment;
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
    
    [self reloadData];
}

-(void)reloadData{
    if (1 ==  self.type) {
        self.navigationItem.title = @"流行的颜文字";
    }
    else{
        self.navigationItem.title = @"最新的颜文字";
    }
    
    [HttpClient requestDataWithPath:@"/api/font/getWordCategory" paramers:@{@"loadType":[NSString stringWithFormat:@"%ld",self.type]} success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(FunWorkSegmentView *)segment{
    
    if (!_segment) {
        CGFloat top = self.navigationController.navigationBar.height+self.navigationController.navigationBar.y;
        _segment = [[FunWorkSegmentView alloc]initWithFrame:CGRectMake(0, top, self.view.width, 68)];
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
    
    [self reloadData];
}

@end
