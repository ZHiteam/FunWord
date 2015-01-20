//
//  RankingViewController.m
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "RankingViewController.h"
#import "WordViewController.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadContent];
}

-(void)loadContent{
    self.navigationItem.title = @"Ranking";
    [self loadDefaultSetting];

}

-(void)viewWillAppear:(BOOL)animated{
    [self loadRequest];
}

-(void)loadRequest{
    [HttpClient requestDataWithPath:@"/api/font/getCategory" paramers:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self praserData:responseObject];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)praserData:(NSDictionary*)data{
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    BOOL result = [data[@"result"]boolValue];;
    
    if (!result){
        return;
    }
    
    NSArray* list = data[@"typeList"];
    if (0 == list.count) {
        return;
    }
    
    for (int i = 0 ; i < list.count ; ++i) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
