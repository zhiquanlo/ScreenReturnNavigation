//
//  HttpClient.m
//  NetWork
//
//  Created by du on 2017/3/10.
//  Copyright © 2017年 du. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking.h>
#import <AFURLRequestSerialization.h>


static NSUInteger const kRequestTimeOut = 30;

@implementation HttpClient

+ (void)post:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^) (NSURLSessionDataTask *dataTask,id responseObjcet))success failure:(void (^)(NSURLSessionDataTask *dataTask,NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:kRequestTimeOut];
    
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_COOKIE];
    if (data.length != 0) {
        NSArray *cookieArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieArray) {
            Log(@"HttpClientCookie:%@",cookie);
            [cookieStorage setCookie:cookie];
        }
    }
    
    Log(@"当前请求:%@\n,参数:%@",urlString,params);
    [manager POST:urlString parameters:params progress:nil success:success failure:failure];
}

+ (void)get:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^) (NSURLSessionDataTask *dataTask,id responseObject))success failure:(void (^)(NSURLSessionDataTask *dataTask,NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:kRequestTimeOut];
    
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_COOKIE];
    if (data.length != 0) {
        NSArray *cookieArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieArray) {
            Log(@"HttpClientCookie:%@",cookie);
            [cookieStorage setCookie:cookie];
        }
    }
    
    Log(@"当前请求:%@\n,参数:%@",urlString,params);
    [manager GET:urlString parameters:params progress:nil success:success failure:failure];
}

@end
