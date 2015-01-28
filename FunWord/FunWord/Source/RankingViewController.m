//
//  RankingViewController.m
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "RankingViewController.h"
#import "WordViewController.h"
#import "EmotionViewController.h"

@interface RankingViewController ()

@end

typedef enum E_CATAGORY_TYPE{
    WORD_CATAGORY = -1001,
    ICON_CATAGORY = -1002
}CatagotyType;

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadContent];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaultSetting];
}

-(void)loadContent{
    self.navigationItem.title = @"Ranking";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern.jpg"]];
    [self loadButton];

}

-(void)loadButton{
    CGFloat leftSpan = 24;
    CGFloat span = 16;
    CGFloat topSpan = 52;
    
    CGFloat width = (self.view.width -leftSpan*2-span)/2;
    CGFloat top = self.navigationController.navigationBar.bottom;
    
    UIImageView* bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, top, self.view.width, 200)];
    bg.image = [UIImage imageNamed:@"ranking_bt_bg"];
    
    [self.view addSubview:bg];
    
    UIButton* wordBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftSpan, top+topSpan, width, width)];
    [wordBtn setImage:[UIImage imageNamed:@"bt_text"] forState:UIControlStateNormal];
    wordBtn.tag = WORD_CATAGORY;
    [wordBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:wordBtn];
    
    UIButton* iconBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftSpan+span+width, wordBtn.top, width, width)];
    [iconBtn setImage:[UIImage imageNamed:@"bt_emotion"] forState:UIControlStateNormal];
    iconBtn.tag = ICON_CATAGORY;
    [iconBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:iconBtn];
    
    UIImageView* roseLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconBtn.bottom+12, self.view.width, 24)];
    roseLine.image = [UIImage imageNamed:@"rose_line"];
    
    [self.view addSubview:roseLine];
}

-(void)buttonAction:(UIButton*)btn{
    if (WORD_CATAGORY == btn.tag) {
        WordViewController* vc = [[WordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        EmotionViewController* vc = [[EmotionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
