//
//  WSYUtils.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "WSYUtils.h"
#include "sys/stat.h"//c语言计算文件大小
#import "sys/utsname.h"//获取手机型号
#import <CommonCrypto/CommonDigest.h>

@implementation WSYUtils


+ (UIToolbar *)addToolbar:(UIViewController*)viewController
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
    toolbar.tintColor = ColorOfSweetBlue;
    toolbar.backgroundColor = ColorOfGrayLight;
    toolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:viewController action:@selector(endEdit)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (void)endEdit
{
    
}


/** AFNetworking网络POST请求*/
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *uploadProgress))progress
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//返回json(NSDictionary对象)
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /** 有些请求需要设置这个属性*/
    //        if (isRespone)
    //        {
    //            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //        }
    
    //拼接参数
    NSMutableDictionary *dicParameter = [NSMutableDictionary dictionaryWithDictionary:(NSMutableDictionary*)parameters];
    
    NSLog(@"%@", URLString);
    NSLog(@"%@", dicParameter);
    
    NSURLSessionDataTask *httpOperation = [manager POST:URLString
                                             parameters:dicParameter
                              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull uploadFormData) {
                                  
                              } progress:^(NSProgress * _Nonnull uploadProgress) {
                                  
                                  progress(uploadProgress);
                                  
                              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  
                                  //[SVProgressHUD dismiss];
                                  
                                  if (success) {
                                      
                                      NSString *jsonString = [WSYUtils JsonObjectConvertNSString:responseObject];
                                      
                                      NSLog(@"%@", jsonString);
                                      
                                      success(task, responseObject);
                                  }
                                  
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  
                                  NSLog(@"Error: %@", error);
                                  
                                  //[SVProgressHUD showWithInfoAndDismissDelay:@"服务器连接失败，请稍后重试" delay:DismissDelayDefault completion:^{
                                      
//                                      if (failure) {

//                                          failure(task, error);
//                                      }

//                                  }];
                                  
                              }];
    
    return httpOperation;
}





/** AFNetworking网络GET请求*/
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *uploadProgress))progress
                      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    AFHTTPSessionManager *manager    = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//返回json(NSDictionary对象)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    //[manager.requestSerializer setValue:access_token_ forHTTPHeaderField:@"X-Auth-Token"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *httpOperation = [NSURLSessionDataTask alloc];
    
    //缓存处理
    BOOL directory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path_MyCachePath isDirectory:&directory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path_MyCachePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    //拼接参数
    NSMutableDictionary *dicParameter = [NSMutableDictionary dictionaryWithDictionary:(NSMutableDictionary*)parameters];
    NSMutableString *requestParameter = [NSMutableString stringWithFormat:@"?"];//[NSMutableString stringWithFormat:@"%@&", url_suffix]
    for (NSString *key in [dicParameter allKeys])
    {
        [requestParameter appendFormat:@"%@=%@&", key, [dicParameter objectForKey:key]];
    }
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", URLString, requestParameter];//拼接url和参数列表
    requestURL = [requestURL substringToIndex:[requestURL length]-1];//减去最后一个&
    
    NSString *filename = [path_MyCachePath stringByAppendingPathComponent:[WSYUtils md5:requestURL]];//用请求url作为文件名,MD5加密
    __block id Data = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    
    NSString *netType = [[NSUserDefaults standardUserDefaults] objectForKey:@"netType"];
    if ([netType isEqualToString:@"NO"])//如果没有网络，返回缓存
    {
        if (Data)
            success(httpOperation, Data);
        else
            failure(nil, nil);
    }
    else
    {
        httpOperation = [manager GET:URLString parameters:dicParameter
                            progress:^(NSProgress *downloadProgress) {
                                NSLog(@"%@", downloadProgress);
                            } success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                Data = responseObject;
                                [NSKeyedArchiver archiveRootObject:Data toFile:filename];
                                
                                NSLog(@"＝＝＝＝＝＝＝＝＝数据来网络＝＝＝＝＝＝＝＝＝");
                                NSLog(@"%@", requestURL);
                                
                                if (success) {
                                    success(task, responseObject);
                                }
                            }
                             failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                 NSLog(@"%@", error);
                                 //                                 if (failure) {
                                 //                                     failure(operation, error);
                                 //                                 }
                                 if (Data)
                                     success(httpOperation, Data);
                                 else
                                     failure(operation, error);
                             }];
    }
    
    return httpOperation;
}




/** AFNetworking上传多张图片，循坏发起多次请求*/
+ (void)uploadImagesWithMoreLoop:(NSString *)url
                      parameters:(NSDictionary *)parameters
                withPostedImages:(NSArray *)imagesArray
                        progress:(void (^)(NSProgress *uploadProgress))progress
                         success:(void (^)(NSArray * resultArray))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    if (imagesArray.count > 0) {
        
        //创建一个临时的数组，用来存储回调回来的结果
        NSMutableArray *temArray = [NSMutableArray array];
        
        for (int i = 0;  i < imagesArray.count; i++) {
            
            UIImage *imageObj = imagesArray[i];
            
            //截取图片
            NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            // 访问路径
            [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                // 上传文件
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                formatter.dateFormat = @"yyyyMMddHHmmss";
                
                NSString *str = [formatter stringFromDate:[NSDate date]];
                
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                [formData appendPartWithFileData:imageData name:@"imgs" fileName:fileName mimeType:@"image/png"];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (progress)
                    progress(uploadProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                
                [temArray addObject:dic];
                
                //当所有图片上传成功后再将结果进行回调
                if (temArray.count == imagesArray.count) {
                    
                    if (success)
                        success(temArray);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure)
                    failure(task, error);
                
            }];
            
        }
        
    }
    
}




/** AFNetworking上传多张图片，一次请求，循坏多个formData*/
+ (void)uploadImagesWithURL:(NSString *)url
                 parameters:(NSDictionary *)parameters
           withPostedImages:(NSArray *)imagesArray
                   progress:(void (^)(NSProgress *uploadProgress))progress
                    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //NSProgress *kProgress = nil;
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<[imagesArray count]; i++)
        {
            UIImage *image = imagesArray[i];
            NSData *imgData = [ImageHandler compressImageData:image];
            
            NSString *fileName = [NSString stringWithFormat:@"picture%d.png", i+1];
            //NSString *paramentName = [NSString stringWithFormat:@"picture%d", i+1];
            NSString *imgs = [NSString stringWithFormat:@"imgs%d", i+1];
            [formData appendPartWithFileData:imgData name:imgs fileName:fileName mimeType:@"image/png"];
        }
        
        //数组转NSData
        //NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:self.arrImageData];
        //[formData appendPartWithFormData:imageData name:@"file"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
            progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
            success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        
//        [SVProgressHUD showWithInfoAndDismissDelay:@"服务器连接失败，请稍后重试" delay:DismissDelayDefault completion:^{
//
//            if (failure) {
//
//                failure(task, error);
//            }
//
//        }];
        
    }];
}





/** AFNetworking上传单张图片*/
+ (void)uploadImagesWithURL:(NSString *)url
                 parameters:(NSDictionary *)parameters
                      image:(UIImage *)image
                   progress:(void (^)(NSProgress *uploadProgress))progress
                    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //NSProgress *kProgress = nil;
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imgData = [ImageHandler compressImageData:image];
        
        NSString *fileName = [NSString stringWithFormat:@"imageHead.png"];
        [formData appendPartWithFileData:imgData name:@"cover" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
            progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
            success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
            failure(task, error);
        
    }];
}





/** AFNetworking上传语音文件*/
+ (void)uploadVoiceWithURL:(NSString *)url
                parameters:(NSDictionary *)parameters
             voiceFilePath:(NSString*)voiceFilePath
                  progress:(void (^)(NSProgress *uploadProgress))progress
                   success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //NSProgress *kProgress = nil;
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *voiceData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@", voiceFilePath]];
        if (voiceData)
            [formData appendPartWithFileData:voiceData name:@"voice" fileName:@"voice.mp3" mimeType:@"audio/mp3"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
            progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
            success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
            failure(task, error);
        
    }];
}



/** 默认参数*/
+ (NSMutableDictionary *)defaultParams
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    return parameters;
}




/** json对象转NSString*/
+ (NSString*)JsonObjectConvertNSString:(id)jsonObject
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //去除掉首尾的空白字符和换行字符
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    return jsonString;
}


+ (NSDictionary*)arrayConvertJsonArray:(NSArray*)array
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *objectData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:objectData
                             
                                                            options:NSJSONReadingMutableContainers
                             
                                                              error:&error];
    return jsonDic;
}




/** responseObject对象转UTF-8编码*/
+ (NSString*)responseObjectConvertUTF8:(id)responseObject
{
    NSData *resultData = responseObject;
    NSString *jsonString =  [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    //jsonString = [jsonString substringFromIndex:1];
    //jsonString = [jsonString substringToIndex:jsonString.length-1];
    return jsonString;
}




/** 将字典或者数组转化为JSON串*/
+ (NSData*)JsonToData:(id)theData
{
    /*
     将字典或者数组转化为NSData，再转NSString
     NSData *data = [Utils toJSONData:NSDictionary or NSArray];
     NSString *jsonString= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     */
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}



/** 将JSON串转化为字典或者数组*/
+ (id)JsonStringToArrayOrNSDictionary:(NSData*)jsonData
{
    /*
     将NSString转化为NSData，再转字典或者数组
     NSData *data = [jsonString dataUsingEncoding:NSASCIIStringEncoding];
     NSDictionary or NSArray = [Utils JsonStringToArrayOrNSDictionary:data];
     */
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        //解析错误
        return nil;
    }
    
}



/**
 @功能：解析网络json信息
 @参数：网络json信息字符串
 */
+ (NSDictionary*)parseJSON:(NSString*)strJSON
{
    NSDictionary *rootDic = [NSDictionary dictionary];
    
    //使用系统的NSJSONSerialization
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
    {
        strJSON = [strJSON stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSData *data = [strJSON dataUsingEncoding:NSUTF8StringEncoding];
        rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //DLog(@"NSJSONSerialization=%@", rootDic);
    }
    return rootDic;
}




/** MD5加密*/
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    //    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}



/** 判断UITextView CGSize*/
+ (CGSize)TakeTextViewSize:(UITextView*)txt
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    //ios7.0以前使用的方法
    CGSize size = [txt.text sizeWithFont:txt.font
                       constrainedToSize:CGSizeMake(txt.bounds.size.width, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
    return size;
#else
    //ios7.0以后使用的方法
    NSDictionary *attribute = @{NSFontAttributeName:txt.font};
    CGSize size = [txt.text boundingRectWithSize:CGSizeMake(txt.bounds.size.width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|
                   NSStringDrawingUsesFontLeading attributes:attribute
                                         context:nil].size;
    return size;
#endif
}



/** 获取UILabel frame*/
+ (CGRect)TakeLabelFrame:(UILabel *)label
{
    // 计算文本的宽度
    NSDictionary *attribute = @{NSFontAttributeName:label.font};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.bounds.size.height) options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    CGRect rect =label.frame;
    label.frame = CGRectMake(rect.origin.x, rect.origin.y, size.width, rect.size.height);
    return label.frame;
}



/** 判断UIButton CGSize*/
+ (CGSize)TakeButtonSize:(UIButton*)button
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    //ios7.0以前使用的方法
    CGSize size = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font
                                  constrainedToSize:CGSizeMake(btn.bounds.size.width, MAXFLOAT)
                                      lineBreakMode:NSLineBreakByWordWrapping];
    return size;
#else
    //ios7.0以后使用的方法
    //        NSDictionary *attribute = @{NSFontAttributeName:btn.titleLabel.font};
    //        CGSize size = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(btn.bounds.size.width, MAXFLOAT)
    //                                                        options:NSStringDrawingUsesLineFragmentOrigin|
    //                       NSStringDrawingUsesFontLeading attributes:attribute
    //                                                        context:nil].size;
    //        return size;
    
    NSString *content = button.titleLabel.text;
    UIFont *font = button.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    
    return buttonSize;
#endif
}






/** 判断UILable CGSize*/
+ (CGSize)TakeLabelSize:(UILabel*)lbl
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    //ios7.0以前使用的方法
    CGSize size = [lbl.text sizeWithFont:lbl.font
                       constrainedToSize:CGSizeMake(lbl.bounds.size.width, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
    return size;
#else
    //ios7.0以后使用的方法
    NSDictionary *attribute = @{NSFontAttributeName:lbl.font};
    CGSize size = [lbl.text boundingRectWithSize:CGSizeMake(lbl.bounds.size.width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|
                   NSStringDrawingUsesFontLeading attributes:attribute
                                         context:nil].size;
    return size;
#endif
    
    //if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)// 当前支持的版本是否低于7.0
    
}


//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing addHeight:(CGFloat)addHeight
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, SCREEN_H) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height+addHeight;
}


/** 判断输入手机号码的合法性*/
+ (BOOL)isValidatePhone:(NSString*)phone
{
    if (phone != nil && [phone length]!= 0)
    {
        if (![WSYUtils ValidatePhone:phone])
        {
            //[SVProgressHUD showErrorWithStatusAndDismissDelay:@"手机号码不正确" delay:DismissDelayDefault];
            return NO;
        }
        else return YES;
    }
    //[SVProgressHUD showErrorWithStatusAndDismissDelay:@"请输入手机号码" delay:DismissDelayDefault];
    return NO;
}




/** 判断输入身份证是否正确*/
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        //[SVProgressHUD showWithInfoAndDismissDelay:@"请输入身份证号码" delay:DismissDelayDefault];
        return NO;
    }
    
    if (![WSYUtils ValidateIDCard:IDCardNumber])
    {
        //[SVProgressHUD showErrorWithStatusAndDismissDelay:@"身份证号码不正确" delay:DismissDelayDefault];
        return NO;
    }
    else return YES;
    
    return NO;
}




/** 利用正则表达式验证手机号码的合法性*/
+ (BOOL)ValidateIDCard:(NSString *)IDCardNumber
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}




/** 判断输入验证码的时间是否过期*/
+ (BOOL)isValidateTimeOut:(NSString*)vdate
{
    NSDate *dateNow = [NSDate date];
    long timeSp = (long)[dateNow timeIntervalSince1970];
    
    long inputSp = (long)[vdate longLongValue];
    int timeSpan = (int)timeSp - (int)inputSp;
    if (timeSpan < 120)
        return YES;
    else
    {
        //[Utils alertMessage:@"验证码超时"];
        return NO;
    }
}



/** 判断输入验证码的合法性*/
+ (BOOL)isValidateCode:(NSString*)code usercode:(NSString*)usercode
{
    if (code != nil && [code length] >= 4 && usercode != nil && [usercode length] >= 4)
    {
        if ([code isEqual:usercode])
            return YES;
        else
        {
            //[SVProgressHUD showErrorWithStatusAndDismissDelay:@"验证码错误" delay:DismissDelayDefault];
            return NO;
        }
    }
    else
    {
        //[SVProgressHUD showWithInfoAndDismissDelay:@"请输入验证码" delay:DismissDelayDefault];
        return NO;
    }
}



/** 判断输入用户名的合法性*/
+ (BOOL)isValidateUserName:(NSString*)UserName
{
    if (UserName != nil && [UserName length] != 0)
    {
        return YES;
    }
    //[SVProgressHUD showWithInfoAndDismissDelay:@"请输入您的用户名" delay:DismissDelayDefault];
    return NO;
}




/** 判断输入密码的合法性*/
+ (BOOL)isValidateTempPassword:(NSString*)TempPassword
{
    if (TempPassword != nil && [TempPassword length] != 0)
    {
        if ([TempPassword length] < 6)
        {
            //[SVProgressHUD showWithInfoAndDismissDelay:@"用户密码不能少于6位数" delay:DismissDelayDefault];
            return NO;
        }
        else
            return YES;
    }
    //[SVProgressHUD showWithInfoAndDismissDelay:@"请输入您的密码" delay:DismissDelayDefault];
    return NO;
}





/** 判断两次输入密码是否相同*/
+ (BOOL)isValidateConfirmPassword:(NSString*)TempPassword ConfirmPassword:(NSString*)ConfirmPassword
{
    if ([TempPassword length] !=0 && (ConfirmPassword != nil && [ConfirmPassword length] != 0))
    {
        if (![TempPassword isEqualToString:ConfirmPassword])
        {
            //[SVProgressHUD showWithInfoAndDismissDelay:@"两次输入的密码不一致" delay:DismissDelayDefault];
            return NO;
        }
        else return YES;
    }
    //[SVProgressHUD showWithInfoAndDismissDelay:@"两次输入的密码不一致" delay:DismissDelayDefault];
    return NO;
}


/** 判断非空输入*/
+ (BOOL)isValidateInput:(NSString*)input
{
    [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //input = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (input != nil && [input length] != 0)
    {
        return YES;
    }
    return NO;
}


/** 判断输入是否为指定格式*/
+ (BOOL)validateChar:(NSString*)value validChar:(NSString*)validChar
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:validChar];
    int i = 0;
    while (i < value.length) {
        NSString * string = [value substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/** 判断输入是否为合格的金额格式*/
+ (BOOL)validateMoney:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (((string.intValue<0) || (string.intValue>9)))
    {
        if ((![string isEqualToString:@"."])) {
            return NO;
        }
        return NO;
    }
    
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger dotNum = 0;
    NSInteger flag=0;
    const NSInteger limited = 2;
    
    if ((int)futureString.length >= 1)
    {
        if ([futureString characterAtIndex:0] == '.')
        {
            //the first character can't be '.'
            return NO;
        }
        if ((int)futureString.length>=2)
        {
            //if the first character is '0',the next one must be '.'
            if (([futureString characterAtIndex:1] != '.'&&[futureString characterAtIndex:0] == '0'))
            {
                return NO;
            }
        }
    }
    
    NSInteger dotAfter = 0;
    for (int i = (int)futureString.length-1; i>=0; i--)
    {
        if ([futureString characterAtIndex:i] == '.')
        {
            dotNum ++;
            dotAfter = flag+1;
            
            if (flag > limited)
            {
                return NO;
            }
            
            if(dotNum>1)
            {
                return NO;
            }
        }
        
        flag++;
    }
    
    if (futureString.length - dotAfter > 7)
    {
        //[MBProgressHUD toastMessage:@"超出最大金额"];
        return NO;
    }
    
    return YES;
}





/** 利用正则表达式验证手机号码的合法性*/
+ (BOOL)ValidatePhone:(NSString *)phone
{
    //NSString *phoneRegex = @"^[1][3-8]+\\d{9}";
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}





/** 利用正则表达式验证邮箱的合法性*/
+ (BOOL)ValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}





/** 显示分栏控制器*/
+ (void)TabBarShow
{
    //    [[TabBarCustom CustomTabBar] TabBarShow];
}





/** 隐藏分栏控制器*/
+ (void)TabBarHidden
{
    //    [[TabBarCustom CustomTabBar] TabBarHidden];
}




/** 分栏控制器点击按钮*/
+ (void)TabBarSelect:(int)SelectIndex
{
    //    UIButton *btn = (UIButton*)[[TabBarCustom CustomTabBar].tabBars viewWithTag:10001+SelectIndex];
    //    [[TabBarCustom CustomTabBar] btn_Clicked:btn];
}



/**
 功能：使用BezierPath画一条水平横线 view 添加水平线的父视图 startX 开始的X坐标 endX 结束的X坐标 lineWidth 线宽 height 高度 type 类型
 */+ (void)DrawHorizontalLine:(UIView*)view startX:(CGFloat)startX endX:(CGFloat)endX lineWidth:(CGFloat)lineWidth height:(CGFloat)height type:(NSString*)type
{
    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    
    if ([type isEqualToString:@"top"])
    {
        //开始点从上左下右的点
        [bezierPath moveToPoint:CGPointMake(startX, 0+lineWidth)];
        //划线点,每一个直线段或者曲线段的结束的地方是下一个的开始的地方。
        [bezierPath addLineToPoint:CGPointMake(endX, 0+lineWidth)];
    }
    else  if ([type isEqualToString:@"bottom"])
    {
        //开始点从上左下右的点
        [bezierPath moveToPoint:CGPointMake(startX, height-lineWidth)];
        //划线点,每一个直线段或者曲线段的结束的地方是下一个的开始的地方。
        [bezierPath addLineToPoint:CGPointMake(endX, height-lineWidth)];
    }
    
    [bezierPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //设置边框颜色
    shapeLayer.strokeColor = ColorOfGrayLight.CGColor;
    shapeLayer.lineWidth = lineWidth; // 线宽
    
    //就是这句话在关联彼此（UIBezierPath和CAShapeLayer）：
    shapeLayer.path = bezierPath.CGPath;
    [view.layer addSublayer:shapeLayer];
}



/**
 功能：使用BezierPath画一条垂直竖线
 参数："view":添加垂直竖线的父视图，"x":开始的X坐标，"y":开始的Y坐标，"lineWidth":线宽，"height":垂直线的高度
 */
+ (void)DrawVerticalLine:(UIView*)view x:(CGFloat)x y:(CGFloat)y lineWidth:(CGFloat)lineWidth height:(CGFloat)height
{
    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    
    //开始点从上左下右的点
    [bezierPath moveToPoint:CGPointMake(x, y)];
    //划线点,每一个直线段或者曲线段的结束的地方是下一个的开始的地方。
    [bezierPath addLineToPoint:CGPointMake(x, y+height)];
    
    [bezierPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //设置边框颜色
    shapeLayer.strokeColor = ColorOfGrayLight.CGColor;
    shapeLayer.lineWidth = lineWidth; // 线宽
    
    //就是这句话在关联彼此（UIBezierPath和CAShapeLayer）：
    shapeLayer.path = bezierPath.CGPath;
    [view.layer addSublayer:shapeLayer];
}




/** NSString转NSDate*/
+ (NSDate*)NSStringConvertNSDate:(NSString*)strDate format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:strDate];
    return date;
}


/** NSDate转NSString*/
+ (NSString*)NSDateConvertNSString:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}


/** dateString转dateString*/
+ (NSString*)dateStringConvertFormat:(NSString*)dateString format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:format];
    NSString *dataStr = [dateFormatter stringFromDate:date];
    return dataStr;
}


/** dateString转dateString*/
+ (NSString*)dateStringConvertFormat2:(NSString*)dateString format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:format];
    NSString *dataStr = [dateFormatter stringFromDate:date];
    return dataStr;
}




/** 时间戳转时间格式*/
+ (NSString*)NSStringConvertTimeInterval:(NSString*)timeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    
    //NSTimeInterval aaa = [timeString longLongValue];
    //NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aaa];
    //NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@", timeString]];
    NSString* dateString = [formatter stringFromDate:date];
    
    return dateString;
}

/** NSDate转时间戳*/
+ (NSString*)timeStringConvertNSString:(NSDate*)date
{
    // 当前时间
    //NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

/** 把GMT日期转换成UTC*/
+ (NSDate*)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}




/** 返回多久之前的时间*/
+ (NSString*)returnUploadTime:(NSString *)timeStr
{
    //Thu June 25 16:36:45 +0800 2015
    
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"E MMM d HH:mm:SS Z y"];
    NSDate *d = [date dateFromString:timeStr];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString= @"";
    
    NSTimeInterval cha = now - late;
    
    //如果小于一小时
    if (cha / 3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        if ([timeString isEqualToString:@"0"])
            timeString = @"1";
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    //如果大于1小时，并且小于24小时
    if (cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        
        //获取昨天的日期
        NSDateFormatter *yesterdayFormatter = [[NSDateFormatter alloc] init];
        [yesterdayFormatter setDateFormat:@"dd"];
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
        [yesterdayFormatter stringFromDate:yesterday];
        NSString *strYesterday = [yesterdayFormatter stringFromDate:yesterday];
        
        //获取传进参数的日期和时间
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"dd HH:mm"];
        NSString *hour = [dateformatter stringFromDate:d];
        
        //比较参数是否大于昨天的最后一秒，小于则显示昨天，大于则显示今天
        if ([hour compare:[NSString stringWithFormat:@"%@ 23:59:59", strYesterday]] <= 0)
        {
            [dateformatter setDateFormat:@"HH:mm"];
            timeString = [NSString stringWithFormat:@"昨天 %@", [dateformatter stringFromDate:d]];
        }
        else
        {
            [dateformatter setDateFormat:@"HH:mm"];
            timeString = [NSString stringWithFormat:@"今天 %@", [dateformatter stringFromDate:d]];
        }
    }
    if (cha/86400 > 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        
        if ([timeString intValue] <= 3)
            timeString=[NSString stringWithFormat:@"%@天前", timeString];
        else
        {
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
            timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:d]];
        }
    }
    return timeString;
}




+ (NSString *)compareCurrentTime:(NSDate*)compareDate
{
    //格式[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if ((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if ((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    else if ((temp = temp/24) <10){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else
    {
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        [dateFormatter setDateFormat:@"E MMM d HH:mm:SS Z y"];
        //        NSString *timeStr = [dateFormatter stringFromDate:compareDate];
        //
        //        NSDateFormatter *date = [[NSDateFormatter alloc] init];
        //        [date setDateFormat:@"E MMM d HH:mm:SS Z y"];
        //        NSDate *d = [date dateFromString:timeStr];
        
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"MM-dd HH:mm"];
        result = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:compareDate]];
    }
    //    else if ((temp = temp/24) <30){
    //        result = [NSString stringWithFormat:@"%ld天前",temp];
    //    }
    //    else if((temp = temp/30) <12){
    //        result = [NSString stringWithFormat:@"%ld个月前",temp];
    //    }
    //    else{
    //        temp = temp/12;
    //        result = [NSString stringWithFormat:@"%ld年前",temp];
    //    }
    return result;
}





+ (NSString*)SecondsToTime:(int)timeInterval
{
    NSString *result = @"";
    long temp = 0;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"00' %d", timeInterval];
    }
    else if ((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%.2ld' %.2d", temp, timeInterval%60];
    }
    return result;
}




+ (NSString*)convertFileSize:(long) size
{
    NSString *sizeStr = @"";
    
    long kb = 1024;
    long mb = kb * 1024;
    long gb = mb * 1024;
    
    if (size >= gb) {
        sizeStr  = [NSString stringWithFormat:@"%.1f GB", (float) size / gb];
    } else if (size >= mb){
        float f = (float) size / mb;
        if (f > 100)
            sizeStr = [NSString stringWithFormat:@"%.0f MB", f];
        else
            sizeStr = [NSString stringWithFormat:@"%.1f MB", f];
    } else if (size >= kb) {
        float f = (float) size / kb;
        if (f > 100)
            sizeStr = [NSString stringWithFormat:@"%.0f KB", f];
        else
            sizeStr = [NSString stringWithFormat:@"%.1f KB", f];
    } else
        sizeStr = [NSString stringWithFormat:@"%ld B", size];
    
    return sizeStr;
}





/** 是否显示网络加载菊花*/
+ (void)NetworkActivityIndicatorVisible:(BOOL)isShowOrHide
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = isShowOrHide;
}




/**
 因为要在UITableViewCell里面的UIView模块里面
 调用self.navigationcontroller pushviewcontroller推入一个新的ViewController，
 需要获取其上层的UIViewController
 */
+ (UIViewController*)GetSuperController:(UIView*)view
{
    id object = [view nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil)
        object = [object nextResponder];
    
    UIViewController *vc = (UIViewController*)object;
    return vc;
}




/** 把聊天中本地发送的UIImage保存到沙盒*/
+ (NSString*)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    NSString *filepath = @"";
    NSString *fileName = @"";
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return fileName;
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        NSString *imgFormat = @"";
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(image);
            imgFormat = @"png";
        }
        else
        {
            imageData = UIImageJPEGRepresentation(image, 1);
            imgFormat = @"jpg";
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return filepath;
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyyMMddHHmmssSSS"];
        NSString *strDate = [dateformatter stringFromDate:date];
        
        fileName = [[NSString alloc] initWithData:imageData encoding:NSISOLatin1StringEncoding];
        fileName = [WSYUtils md5:strDate];
        fileName = [NSString stringWithFormat:@"%@.%@", fileName, imgFormat];
        filepath = [NSString stringWithFormat:@"%@/%@", aPath, fileName];
        
        [imageData writeToFile:filepath atomically:YES];
        return [NSString stringWithFormat:@"%@/%@", aPath, fileName];
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    return fileName;
}




/** 图片压缩*/
+ (UIImage*)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}




/** 遍历文件夹获得文件夹大小，返回多少M*/
+ (float)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}




/** c语言获取单个文件大小,返回kb*/
+ (long long)fileSizeAtPath:(NSString*)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0)
    {
        return st.st_size;
    }
    return 0;
}




/** OC获取单个文件大小,返回kb*/
+ (float)fileNSSizeAtPath:(NSString*)filePath
{
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize] / 1024.0;
}




/** 过滤html标签*/
+ (NSString*)HTMLFilter:(NSString*)description
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:description];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        description = [description stringByReplacingOccurrencesOfString:
                       [NSString stringWithFormat:@"%@>", text]
                                                             withString:@""];
    }
    
    description = [description stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&lt" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&cent;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&pound;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&yen;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&euro;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&sect;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&copy;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&reg;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&trade;" withString:@""];
    
    return description;
}



/**
 *  获取网络当前时间
 */
+ (NSDate *)getInternetDate
{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 实例化NSMutableURLRequest，并进行参数配置
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //处理返回的数据
    //NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"response is %@",response);
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    return netDate;
}


//获取当前的时间
+ (NSString*)getCurrentTimes
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}



/** 获取手机型号*/
+ (NSString*)getModel
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    return deviceString;
}

/**导航栏返回按钮*/
+ (void)navigationBarReturn:(UIViewController *)VC
{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 20, 20);
    //[btnBack setBackgroundImage:BACKBUTTON forState:UIControlStateNormal];
    [btnBack addTarget:VC.navigationController action:@selector((popViewControllerAnimated:)) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    [VC.navigationItem setLeftBarButtonItem:leftItem animated:YES];
}

/**添加圆角*/
+ (void)addRadius:(UIView *)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
}

/**添加border*/
+ (void)addBorder:(UIView *)view
{
    view.layer.borderWidth = 0.3;
    view.layer.borderColor = ColorOfGrayLight.CGColor;
    view.layer.masksToBounds = YES;
}

/**添加圆角border*/
+ (void)addRadiusBorder:(UIView *)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 0.3;
    view.layer.borderColor = ColorOfGrayLight.CGColor;
}

/** 返回到指定索引的控制器*/
+ (void)popToViewControllerWithIndex:(int)index vcSelf:(UIViewController*)vcSelf
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:vcSelf.navigationController.viewControllers];
    UIViewController *VC = array[array.count-index];
    [vcSelf.navigationController popToViewController:VC animated:YES];
}



@end
