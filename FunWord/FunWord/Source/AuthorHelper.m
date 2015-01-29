//
//  AuthorHelper.m
//  FunWord
//
//  Created by elvis on 15/1/29.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "AuthorHelper.h"
#import "WeiboSDK.h"
#import "WBHttpRequest+WeiboUser.h"
#import "WeiboUser.h"


#define SSO_TYPE @"sso_type"

#define TYPE_SINA_WEIBO @"type_sina_weibo"
#define TYPE_WEIXIN @"type_weixin"
#define TYPE_QQ @"type_qq"

#define CURRENT_TYPE    @"current_type"

@interface AuthorHelper()<WeiboSDKDelegate,WBHttpRequestDelegate>
@property (nonatomic,copy)SSOResponseBlock weiboResponse;
@property (nonatomic,strong) NSString*  weiboRedirectURI;
@property (nonatomic,strong) NSString*  weiboKey;
@property (nonatomic,strong) NSString* weiboSecret;
@property (nonatomic,strong) NSDictionary* weiboInfo;

@property (nonatomic,strong) NSString*  currentType;
@end

@implementation AuthorHelper

+(AuthorHelper*)instance{
    static AuthorHelper* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AuthorHelper alloc]init];
        shareInstance.weiboInfo = [[NSUserDefaults standardUserDefaults]valueForKey:TYPE_SINA_WEIBO];
        shareInstance.currentType = [[NSUserDefaults standardUserDefaults]valueForKey:CURRENT_TYPE];
    });
    return shareInstance;
}

+(void)registerWeiboWithAppKey:(NSString *)key appSecret:(NSString *)secret redirectUri:(NSString *)uri{
    [AuthorHelper instance].weiboRedirectURI = uri;
    [AuthorHelper instance].weiboKey = key;
    [AuthorHelper instance].weiboSecret = secret;
    
    [WeiboSDK registerApp:key];
}

+(void)weiboSSO:(SSOResponseBlock)responseBlock{
    
    AuthorHelper* helper = [AuthorHelper instance];
    
    if (helper.weiboInfo) {
        responseBlock(helper.weiboInfo);
       [[NSUserDefaults standardUserDefaults]setObject:TYPE_SINA_WEIBO forKey:CURRENT_TYPE];
    }
    else if ([WeiboSDK isCanSSOInWeiboApp]) {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = [AuthorHelper instance].weiboRedirectURI;
        request.scope = @"all";

        [WeiboSDK sendRequest:request];
        
        helper.weiboResponse = responseBlock;
    }
}

+(BOOL)handleUrl:(NSURL*)url{
    return [WeiboSDK handleOpenURL:url delegate:[AuthorHelper instance]];
}

#pragma -mark WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    /// 认证结果
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        WBAuthorizeResponse* authorResponse = (WBAuthorizeResponse*)response;
        
        /// 获取头像
        [WBHttpRequest requestForUserProfile:authorResponse.userID
                             withAccessToken:authorResponse.accessToken
                          andOtherProperties:nil
                                       queue:nil
                       withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                           if (!error) {
                               if ([result isKindOfClass:[WeiboUser class]]) {
                                   WeiboUser* user = (WeiboUser*)result;
                                   NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:5];
                                   
                                   [dic setObject:TYPE_SINA_WEIBO forKey:SSO_TYPE];
                                   if (user.avatarHDUrl){
                                       [dic setObject:user.avatarHDUrl forKey:@"icon"];
                                   }
                                   if (user.userID) {
                                       [dic setObject:user.userID forKey:@"uid"];
                                   }
                                   if (user.name) {
                                       [dic setObject:user.name forKey:@"name"];
                                   }
                                   if (authorResponse.accessToken) {
                                       [dic setObject:authorResponse.accessToken forKey:@"token"];
                                   }
                                   
                                   if (self.weiboResponse) {
                                       NSLog(@"%@",dic);
                                       self.weiboResponse(dic);
                                       self.weiboResponse = nil;
                                       [[NSUserDefaults standardUserDefaults]setObject:dic forKey:TYPE_SINA_WEIBO];
                                       [[NSUserDefaults standardUserDefaults]setObject:TYPE_SINA_WEIBO forKey:CURRENT_TYPE];
                                   }
                               }
                               NSLog(@"%@",result);
                           }
                           else if(self.weiboResponse){
                               self.weiboResponse(nil);
                           }
        }];
    }
}

+(SSOType)currentSSOType{
    AuthorHelper* helper=  [AuthorHelper instance];
    if ([helper.currentType isEqualToString:TYPE_SINA_WEIBO]) {
        return SSO_TYPE_Sina_Weibo;
    }
    else if ([helper.currentType isEqualToString:TYPE_WEIXIN]){
        return SSO_TYPE_WeiXin;
    }
    else if ([helper.currentType isEqualToString:TYPE_QQ]){
        return SSO_TYPE_QQ;
    }
    
    return SSO_TYPE_None;
}

+(void)logout{
    switch ([AuthorHelper currentSSOType]) {
        case SSO_TYPE_Sina_Weibo:
            [AuthorHelper logoutWeiBo];
            break;
            
        default:
            break;
    }
}

+(void)logoutWeiBo{
    AuthorHelper* hepler = [AuthorHelper instance];
    if (!hepler.weiboInfo) {
        return;
    }
    
    NSString* token = hepler.weiboInfo[@"token"];
    if (token) {
        [WeiboSDK logOutWithToken:token delegate:self withTag:@"user1"];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:hepler.currentType];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:CURRENT_TYPE];
    hepler.currentType = @"";
    

}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

+(NSDictionary *)currentLoginInfo{
    switch ([AuthorHelper currentSSOType]) {
        case SSO_TYPE_Sina_Weibo:
            return [AuthorHelper instance].weiboInfo;
            break;
            
        default:
            break;
    }
    return nil;
}

@end
