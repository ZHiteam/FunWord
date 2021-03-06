//
//  WordCagatoryViewController.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordCagatoryViewController.h"
#import "CatagoryModel.h"
#import "WordTableView.h"

@interface WordCagatoryViewController()
@property (nonatomic,strong) WordTableView* contentTable;
@end

@implementation WordCagatoryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_bg2"]];
    
    if (self.userInfo) {
        CatagoryModel* model = nil;
        if ([self.userInfo isKindOfClass:[CatagoryModel class]]) {
            model = self.userInfo;
        }
        self.navigationItem.title = model.name;
        
        [self requestWithModel:model];
    }
    
    [self.view addSubview:self.contentTable];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaultSetting];
}


-(WordTableView *)contentTable{
    
    if (!_contentTable) {
        CGFloat top = 0;
        CGFloat height = self.view.height - top-self.tabBarController.tabBar.height;
        
        _contentTable = [[WordTableView alloc]initWithFrame:CGRectMake(0, top, self.view.width, height)];
    }
    
    return _contentTable;
}


#pragma -mark load data
-(void)requestWithModel:(CatagoryModel*)model{
    if (!model){
        return;
    }
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    if (model.catagoryId) {
        [dic setObject:model.modelId forKey:@"categoryId"];
    }
    if (model.loadType) {
        [dic setObject:model.loadType forKey:@"loadType"];
    }
    
    
    [HttpClient requestDataWithPath:@"/api/font/getWordList" paramers:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (![responseObject[@"result"]boolValue]) {

                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            else{
                [self praserData:responseObject];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)praserData:(NSDictionary*)data{
    NSArray* list = data[@"popularWordList"];
    if (!list) {
        list = data[@"richWordList"];
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
