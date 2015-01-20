//
//  HttpClient.m
//  GreenFuture
//
//  Created by elvis on 8/27/14.
//  Copyright (c) 2014 HKWF. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking/AFNetworking.h>

#define kTimeoutInterval                10.0

@interface HttpClient(){
    AFHTTPRequestOperationManager*  _client;
}
@property (nonatomic,strong) UIControl*    mask;
@end


@implementation HttpClient

-(id)init{
    self = [super init];
    
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"http://ad.meimotuan.com"];
        _client = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
        _client.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        _client.requestSerializer.timeoutInterval = kTimeoutInterval;
    }
    
    return self;
}

+(HttpClient*)instance{
    static HttpClient *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HttpClient alloc] init];
    });
    return shareInstance;
}

-(void)prepareData{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络切换到未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络不可用");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"使用2G/3G网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"使用wifi网络");
                break;
            default:
                break;
        }
    }];
}

+(void)requestDataWithPath:(NSString *)path paramers:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    HttpClient* client = [HttpClient instance];
    [client startAnimation];
    [client->_client GET:path parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [client stopAnimation];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [client stopAnimation];
        failure(error);
    }];
}

+(void)postDataWithPath:(NSString *)path paramers:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    HttpClient* client = [HttpClient instance];
    [client startAnimation];
    [client->_client POST:path parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [client stopAnimation];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [client stopAnimation];
        failure(error);
    }];
}

-(UIView*)mainView{
    UIView* mainView = [UIApplication sharedApplication].keyWindow;
    
    return mainView;
}

-(UIControl *)mask{
    if (!_mask){
        _mask = [[UIControl alloc]initWithFrame:self.mainView.bounds];
        _mask.backgroundColor = [UIColor clearColor];
    }
    return _mask;
}

-(void)startAnimation{
    [[self mainView] addSubview:self.mask];
//    [SVProgressHUD showWithStatus:@"加载中..."];
}

-(void)stopAnimation{
    [self.mask removeFromSuperview];
//    [SVProgressHUD dismiss];
}

-(void)startAnimationWithProgress:(CGFloat)progress{
    [self.mask removeFromSuperview];
//    [SVProgressHUD showProgress:progress status:@"上传中..."];
}
@end
