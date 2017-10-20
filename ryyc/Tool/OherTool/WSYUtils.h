//
//  WSYUtils.h
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"//AFNetworking网络请求
#import <CommonCrypto/CommonDigest.h>//MD5

@interface WSYUtils : NSObject


/** 默认参数*/
+(NSMutableDictionary *)defaultParams;




/**  键盘添加工具栏*/
+ (UIToolbar *)addToolbar:(UIViewController*)viewController;


/** AFNetworking网络POST请求*/
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *uploadProgress))progress
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/** AFNetworking网络GET请求*/
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *downloadProgress))progress
                      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/** AFNetworking上传多张图片，循坏发起多次请求*/
+ (void)uploadImagesWithMoreLoop:(NSString *)url
                      parameters:(NSDictionary *)parameters
                withPostedImages:(NSArray *)imagesArray
                        progress:(void (^)(NSProgress *uploadProgress))progress
                         success:(void (^)(NSArray * resultArray))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/** AFNetworking上传多张图片，一次请求，循坏多个formData*/
+ (void)uploadImagesWithURL:(NSString *)url
                 parameters:(NSDictionary *)parameters
           withPostedImages:(NSArray *)imagesArray
                   progress:(void (^)(NSProgress *uploadProgress))progress
                    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/** AFNetworking上传单张图片*/
+ (void)uploadImagesWithURL:(NSString *)url
                 parameters:(NSDictionary *)parameters
                      image:(UIImage *)image
                   progress:(void (^)(NSProgress *uploadProgress))progress
                    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/** AFNetworking上传语音文件*/
+ (void)uploadVoiceWithURL:(NSString *)url
                parameters:(NSDictionary *)parameters
             voiceFilePath:(NSString*)voiceFilePath
                  progress:(void (^)(NSProgress *uploadProgress))progress
                   success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/** json对象转NSString*/
+ (NSString*)JsonObjectConvertNSString:(id)jsonObject;


/** NSarray对象转json数组*/
+ (NSDictionary*)arrayConvertJsonArray:(NSArray*)array;


/** responseObject对象转UTF-8编码*/
+ (NSString*)responseObjectConvertUTF8:(id)responseObject;


/** 将字典或者数组转化为JSON串*/
+ (NSData*)JsonToData:(id)theData;


/** 将JSON串转化为字典或者数组*/
+ (id)JsonStringToArrayOrNSDictionary:(NSData*)jsonData;


/**
 @功能：解析网络json信息
 @参数：网络json信息字符串
 */
+ (NSDictionary*)parseJSON:(NSString*)strJSON;



/** MD5加密*/
+ (NSString *)md5:(NSString *)str;



/** 判断UITextView CGSize*/
+ (CGSize)TakeTextViewSize:(UITextView*)txt;



/** 获取UILabel frame*/
+ (CGRect)TakeLabelFrame:(UILabel *)label;



/** 判断UIButton CGSize*/
+ (CGSize)TakeButtonSize:(UIButton*)button;



/** 判断UILable CGSize*/
+ (CGSize)TakeLabelSize:(UILabel*)lbl;


/** 计算UILabel的高度(带有行间距的情况)*/
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing addHeight:(CGFloat)height;


/** 判断输入手机号码的合法性*/
+ (BOOL)isValidatePhone:(NSString*)phone;


/** 判断输入身份证是否正确*/
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber;


/** 判断输入验证码的时间是否过期*/
+ (BOOL)isValidateTimeOut:(NSString*)vdate;


/** 判断输入验证码的合法性*/
+ (BOOL)isValidateCode:(NSString*)code usercode:(NSString*)usercode;



/** 判断输入用户名的合法性*/
+ (BOOL)isValidateUserName:(NSString*)UserName;



/** 判断输入密码的合法性*/
+ (BOOL)isValidateTempPassword:(NSString*)TempPassword;


/** 判断两次输入密码是否相同*/
+ (BOOL)isValidateConfirmPassword:(NSString*)TempPassword ConfirmPassword:(NSString*)ConfirmPassword;


/** 判断非空输入*/
+ (BOOL)isValidateInput:(NSString*)input;


/** 判断输入是否为指定格式*/
+ (BOOL)validateChar:(NSString*)value validChar:(NSString*)validChar;


/** 判断输入是否为合格的金额格式*/
+ (BOOL)validateMoney:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


/** 利用正则表达式验证手机号码的合法性*/
+ (BOOL)ValidatePhone:(NSString *)phone;


//利用正则表达式验证邮箱的合法性
+ (BOOL)ValidateEmail:(NSString *)email;


/** 隐藏分栏控制器*/
+ (void)TabBarHidden;


/** 显示分栏控制器*/
+ (void)TabBarShow;


/** 分栏控制器点击按钮*/
+ (void)TabBarSelect:(int)SelectIndex;


/**
 功能：使用BezierPath画一条水平线
 @param view 添加水平线的父视图
 @param startX 开始的X坐标
 @param endX 结束的X坐标
 @param lineWidth 线宽
 @param height 高度
 @param type 类型
 */
+ (void)DrawHorizontalLine:(UIView*)view startX:(CGFloat)startX endX:(CGFloat)endX lineWidth:(CGFloat)lineWidth height:(CGFloat)height type:(NSString*)type;


/**
 功能：使用BezierPath画一条垂直线
 参数："view":添加垂直竖线的父视图，"x":开始的X坐标，"y":开始的Y坐标，"lineWidth":线宽，"height":垂直线的高度
 */
+ (void)DrawVerticalLine:(UIView*)view x:(CGFloat)x y:(CGFloat)y lineWidth:(CGFloat)lineWidth height:(CGFloat)height;




+ (NSDate*)NSStringConvertNSDate:(NSString*)strDate format:(NSString*)format;


/** NSDate转NSString*/
+ (NSString*)NSDateConvertNSString:(NSDate*)date format:(NSString*)format;



/** dateString转dateString*/
+ (NSString*)dateStringConvertFormat:(NSString*)dateString format:(NSString*)format;


/** dateString转dateString*/
+ (NSString*)dateStringConvertFormat2:(NSString*)dateString format:(NSString*)format;


/** 时间戳转时间格式*/
+ (NSString*)NSStringConvertTimeInterval:(NSString*)timeString;


/** NSDate转时间戳*/
+ (NSString*)timeStringConvertNSString:(NSDate*)date;


/** 把GMT日期转换成UTC*/
+ (NSDate*)getNowDateFromatAnDate:(NSDate *)anyDate;




/** 返回多久之前的时间*/
+ (NSString *)returnUploadTime:(NSString *)timeStr;
+ (NSString *)compareCurrentTime:(NSDate*)compareDate;




/** 秒数转时间*/
+ (NSString*)SecondsToTime:(int)timeInterval;




/** 文件大小字节转换*/
+ (NSString*)convertFileSize:(long) size;





/** 是否显示网络加载菊花*/
+ (void)NetworkActivityIndicatorVisible:(BOOL)isShowOrHide;




/**
 因为要在UITableViewCell里面的UIView模块里面
 调用self.navigationcontroller pushviewcontroller推入一个新的ViewController，
 需要获取其上层的UIViewController
 */
+ (UIViewController*)GetSuperController:(UIView*)view;





/** 把聊天中本地发送的UIImage保存到沙盒*/
+ (NSString*)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;




/** 图片压缩*/
+ (UIImage*)scaleImage:(UIImage *)image toScale:(float)scaleSize;



/** 遍历文件夹获得文件夹大小，返回多少M*/
+ (float)folderSizeAtPath:(NSString*)folderPath;



/** c语言获取单个文件大小*/
+ (long long)fileSizeAtPath:(NSString*)filePath;



/** OC获取单个文件大小,返回kb*/
+ (float)fileNSSizeAtPath:(NSString*)filePath;



/** 过滤html标签*/
+ (NSString*)HTMLFilter:(NSString*)description;



/** 获取网络当前时间*/
+ (NSDate *)getInternetDate;



+ (NSString *)getCurrentTimes;




/** 获取手机型号*/
+ (NSString*)getModel;



/**导航栏返回按钮*/
+ (void)navigationBarReturn:(UIViewController *)VC;


/**添加圆角*/
+ (void)addRadius:(UIView *)view;


/**添加border*/
+ (void)addBorder:(UIView *)view;


/**添加圆角border*/
+ (void)addRadiusBorder:(UIView *)view;


+ (void)popToViewControllerWithIndex:(int)index vcSelf:(UIViewController*)vcSelf;


@end

