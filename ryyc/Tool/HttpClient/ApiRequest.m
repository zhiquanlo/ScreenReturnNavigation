//
//  ApiRequest.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "ApiRequest.h"
#import "HttpClient.h"

@implementation ApiRequest

#define SET_COOKIE     NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];\
NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];\
[[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:DEVICE_COOKIE];\
[[NSUserDefaults standardUserDefaults] synchronize];\

#define CREATE_POST(url,PRAMS,PKG)    \
[HttpClient post:url parameters:PRAMS success:^(NSURLSessionDataTask *dataTask, id responseObjcet) {\
SET_COOKIE\
NSString *string =  [[NSString alloc]initWithData:(NSData *)responseObjcet encoding:NSUTF8StringEncoding];\
Log(@"HttpClientResponseObject-->%@",string);\
NSError *error = nil;\
PKG *model = [[PKG alloc]initWithString:string error:&error];\
if (error == nil) {\
if (model.error_code.intValue == 0) {\
success(model);\
}\
else{\
failure(model.error_type.intValue,model.error_msg);\
}\
}\
else{\
failure(-1,@"JSON解析错误");\
Log(@"JSON解析错误");\
}\
} failure:^(NSURLSessionDataTask *dataTask, NSError *error) {\
Log(@"请求出错:%@",error);\
if ([AFNetworkReachabilityManager sharedManager].reachable) {\
failure(-1,@"请求失败");\
}\
else{\
failure(-1,@"网络异常,请检查你的网络状况");\
}\
}];\



#define CREATE_GET(url,PARAMS,PKG) \
[HttpClient get:url parameters:PARAMS success:^(NSURLSessionDataTask *dataTask, id responseObject) {\
NSString *string =  [[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];\
Log(@"responseObject-->%@",string);\
NSError *error = nil;\
PKG *model = [[PKG alloc]initWithString:string error:&error];\
if (error == nil) {\
if (model.error_code.intValue == 0) {\
success(model);\
}\
else{\
failure(model.error_type.intValue,model.error_msg);\
}\
}\
else{\
Log(@"JSON解析错误");\
}\
} failure:^(NSURLSessionDataTask *dataTask, NSError *error) {\
if ([AFNetworkReachabilityManager sharedManager].reachable) {\
failure(-1,@"请求失败");\
}\
else{\
failure(-1,@"网络异常,请检查你的网络状况");\
}\
}];\

@end
