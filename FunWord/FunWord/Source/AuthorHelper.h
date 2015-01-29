//
//  AuthorHelper.h
//  FunWord
//
//  Created by elvis on 15/1/29.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SSOResponseBlock)(NSDictionary* info);

typedef enum SSO_TYPE{
    SSO_TYPE_None,
    SSO_TYPE_Sina_Weibo,
    SSO_TYPE_WeiXin,
    SSO_TYPE_QQ
}SSOType;

@interface AuthorHelper : NSObject

/// 注册微博
+(void)registerWeiboWithAppKey:(NSString*)key appSecret:(NSString*)secret redirectUri:(NSString*)uri;

/// 微博登录
+(void)weiboSSO:(SSOResponseBlock)responseBlock;

/// 注销
+(void)logoutWeiBo;

+(void)logout;

/// 当前登录类型
+(SSOType)currentSSOType;

/// 当前登录信息
+(NSDictionary*)currentLoginInfo;


+(BOOL)handleUrl:(NSURL*)url;

@end
