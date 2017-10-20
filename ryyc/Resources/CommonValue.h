//
//  CommonValue.h
//  YouCai
//
//  Created by du on 2017/3/10.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#ifndef CommonValue_h
#define CommonValue_h


#define statusAuthenticationfailed 20022//身份异常
#define KeypassW @"fDe16F9c"
#define notNull(type) ![type isKindOfClass:[NSNull class]] //类型为null判断
#define checkString(str) str == nil ? @"" : str//判字符串
#define checkNumberString(str) str == nil || [str isKindOfClass:[NSNull class]] ? @"0.00": str
#define convertNilToZeroStr(str) str == nil ? @"0" : str
#define kFoundMoney @"4"

/*-------------------------屏幕适配-----------------------------*/
#pragma mark - 常用宏
// keyWindow获取宏
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
// 主场景尺寸获得
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_H SCREEN_BOUNDS.size.height
#define SCREEN_W SCREEN_BOUNDS.size.width
#define iPhone6P (SCREEN_H == 736)
#define iPhone6 (SCREEN_H == 667)
#define iPhone5 (SCREEN_H == 568)
#define iPhone4 (SCREEN_H == 480)
/*------------------------颜色-----------------------------*/
//十六进制颜色转换
#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorRGB(r,g,b) UIColorRGBA(r,g,b,1.0f)

#define greenc 0x028b33
#define bluec 0x20a8ff
#define redc 0xf74646
#define blackc 0x323232   //主要的文字(标题)颜色
#define blackGroungC 0xeeeeee  //背景色
#define blackLineC 0xf2f2f2 //线条的颜色
#define grayc 0xa5a5a5
#define grayTextc 0x808080//文本
#define blackText2c 0x727272
#define orangec 0xf8b551
#define orangec2 0xff7800
#define whitec 0xffffff
#define bulec 0x1E6ED7
#define kBackgroundColor 0xf2f2f2 //控制器背景色

#define backGroungC [UIColor colorWithRed:75 / 255.0 green:75 / 255.0 blue:75 / 255.0 alpha:0.8] //黑色背景

/*------------------------------------------------------*/
// 弱引用
#define Weak_Self __weak typeof(self) weakSelf = self
#pragma mark - 调试替代宏
// 调试的输出宏
#ifdef DEBUG 
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...)
#endif

// 方法打印宏
#define LOG_FUNC DLog(@"%s",__func__);


//HUD
#define SHOWHUD [SVProgressHUD showWithStatus:@"loading..."];
#define ShowHud(str)     [SVProgressHUD showWithStatus:@"提现中..."];\
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];\

#define MISSHUD [SVProgressHUD dismiss];

//TOAST
#define ShowToast(str) [RYDPopupWindowTool PopupWindowWith:str]

#define ShowStrokeToast(str) [RYDPopupWindowTool popStrokeToast:str]

#define DEVICE_COOKIE @"DEVICE_COOKIE"

#define kLoginSuccess @"loginSuccess"

#define VARIFY_WITH_URL(urlString)     UIViewController *vc = [RYDRouter getNextStepControllerWithUrlString:urlString];\
                if(vc){\
                NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];\
                [marr removeLastObject];\
                self.navigationController.viewControllers = marr;\
                [self.navigationController pushViewController:vc animated:NO];\
                urlString = nil; \
                return;\
            }\
//友盟统计
#define MobClicked(eventStr) [MobClick event:eventStr]
//记录当前用户的点击事件
#define MobUserClicked(eventStr) NSDictionary *dict = @{@"uid":checkString([GCAccountTool account].cidStr)};\
    [MobClick event:eventStr attributes:dict];

#endif /* CommonValue_h */
