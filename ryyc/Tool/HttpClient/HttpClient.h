//
//  HttpClient.h
//  NetWork
//
//  Created by du on 2017/3/10.
//  Copyright © 2017年 du. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HttpClient : NSObject

+ (void)post:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^) (NSURLSessionDataTask *dataTask,id responseObjcet))success failure:(void (^)(NSURLSessionDataTask *dataTask,NSError *error))failure;

+ (void)get:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^) (NSURLSessionDataTask *dataTask,id responseObject))success failure:(void (^)(NSURLSessionDataTask *dataTask,NSError *error))failure;

@end
