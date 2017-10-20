//
//  WSYCommonValue.h
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#ifndef WSYCommonValue_h
#define WSYCommonValue_h

//分栏控制器高度
#define TabBarHeight 49




/** 颜色*/
#pragma mark - 颜色
/** 透明*/
#define ColorOfClear [UIColor clearColor]
/** 随机颜色*/
#define ColorOfRandom [UIColor randomColor]
/** 黑色*/
#define ColorOfBlack UIColorRGBA(0, 0, 0, 1)
/** 白色*/
#define ColorOfWhite UIColorRGBA(255, 255, 255, 1)
/** 很浅的灰色*/
#define ColorOfGrayTooLight UIColorRGBA(239, 239, 244, 1)
/** 浅灰色字体颜色*/
#define ColorOfGrayLight UIColorRGBA(200, 200, 200, 1)
/** 浅灰色字体颜色*/
#define ColorOfGrayMiddle UIColorRGBA(150, 150, 150, 1)
/** 深灰色字体颜色*/
#define ColorOfGrayDark UIColorRGBA(80, 80, 80, 1)
/** 青草绿字体颜色*/
#define ColorOfGreenColor UIColorRGBA(131, 170, 12, 1)
/** 糖果绿色字体颜色*/
#define ColorOfSweetGreen UIColorRGBA(54, 195, 150, 1)
/** 糖果粉红字体颜色*/
#define ColorOfSweetRed UIColorRGBA(251, 83, 89, 1)
/** 糖果蓝字体颜色*/
#define ColorOfSweetBlue UIColorRGBA(32, 119, 227, 1)
/** 程序主浅蓝色*/
#define ColorOfSweetBlueLight UIColorRGBA(68, 174, 242, 1)
/** 程序主浅蓝色*/
#define ColorOfSweetBlueTooLight UIColorRGBA(232, 246, 255, 1)
/** 深红色*/
#define ColorOfDarkRed UIColorRGBA(216, 0, 18, 1)
/** 状态息金橙色色*/
#define ColorOfOrange UIColorRGBA(245, 106, 9, 1)
/** 淡黄色*/
#define ColorOfYellowLight UIColorRGBA(253, 242, 213, 1)




/** 字体大小（常规/粗体）*/
#pragma mark - 字体大小（常规/粗体）
#define fontSizeMinMinMin [UIFont systemFontOfSize:11]
#define fontSizeMinMin [UIFont systemFontOfSize:12]
#define fontSizeMin [UIFont systemFontOfSize:13]

#define fontSizeMinForI6P (ISIPHONE6P ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:15])
#define fontSizeMinMinForI6P (ISIPHONE6P ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:13])
#define fontSizeMinMinMinForI6P (ISIPHONE6P ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:11])
#define fontSizeMinMinMinMinForI6P (ISIPHONE6P ? [UIFont systemFontOfSize:10] : [UIFont systemFontOfSize:9])

#define fontSizeTitle (ISIPHONE6P ? [UIFont systemFontOfSize:17] : [UIFont systemFontOfSize:15])
#define fontSizeContent (ISIPHONE6P ? [UIFont systemFontOfSize:15] : [UIFont systemFontOfSize:13])
#define fontSizeDescribe (ISIPHONE6P ? [UIFont systemFontOfSize:13] : [UIFont systemFontOfSize:11])
#define fontSizeTitleBold (ISIPHONE6P ? [UIFont boldSystemFontOfSize:19] : [UIFont boldSystemFontOfSize:17])
#define fontSizeTitleBoldPlus (ISIPHONE6P ? [UIFont boldSystemFontOfSize:22] : [UIFont systemFontOfSize:19])
#define fontSizeTitlePlus (ISIPHONE6P ? [UIFont systemFontOfSize:19] : [UIFont systemFontOfSize:17])

#define fontSizeMax [UIFont systemFontOfSize:20]
#define fontSizeMaxBold [UIFont boldSystemFontOfSize:20]
#define fontSizeMaxMax [UIFont systemFontOfSize:25]
#define fontSizeMaxMaxBold [UIFont boldSystemFontOfSize:25]
#define fontSizeMaxMaxMax [UIFont systemFontOfSize:30]




#pragma mark - 屏幕判断
//是否Retina屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) :NO)
//是否iPhone5
#define ISIPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISIPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//是否是iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




/** 文件路径*/
#pragma mark - 文件路径
/** 文档目录*/
#define path_NSDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/** 库文件目录*/
#define path_NSLibraryDirectory [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/** library库文件缓存目录*/
#define path_NSCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/** 临时目录*/
#define path_NSTemporaryDirectory NSTemporaryDirectory()
/** 自定义缓存路径*/
#define path_MyCachePath [path_NSCachesDirectory stringByAppendingPathComponent:@"myCache"]




/**  系统判断*/
#pragma mark - 系统判断
#define weakSelf_MACRO(name) __weak typeof(self) name = self;
/** 程序版本号*/
#define VersionCode [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 程序build号*/
#define BulidCode [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** 当前手机系统版本号*/
#define FSystenVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
/** 当前手机系统版本号*/
#define DSystenVersion ([[[UIDevice currentDevice] systemVersion] doubleValue])




/** 表单验证用*/
#pragma mark - 表单验证用
#define kValidChar @"@.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kValidNum @"0123456789"
#define kValidIDNum @"0123456789xX"
#define kValidFloat @".0123456789"




/** 控制台调试打印*/
#pragma mark - 控制台调试打印
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif




#import "WSYUtils.h"
#import "UIColor+RandomColor.h"
#import "ImageHandler.h"
#import "SDImageView.h"
#import "SVProgressHUD+Expand.h"

#endif /* WSYCommonValue_h */
