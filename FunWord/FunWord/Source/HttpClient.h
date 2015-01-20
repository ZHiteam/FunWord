//
//  HttpClient.h
//  GreenFuture
//
//  Created by elvis on 8/27/14.
//  Copyright (c) 2014 HKWF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define k_SiteKey   @"site"

@interface HttpClient : NSObject

/// GET方法请求
+(void)requestDataWithPath:(NSString*)path
                  paramers:(NSDictionary*)paramers
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/// POST方法请求
+(void)postDataWithPath:(NSString*)path
               paramers:(NSDictionary*)paramers
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;
@end
