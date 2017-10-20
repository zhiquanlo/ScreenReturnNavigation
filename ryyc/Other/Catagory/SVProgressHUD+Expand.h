//
//  SVProgressHUD+Expand.h
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (Expand)

/**  没有内容的成功HUD 指定时间后回调*/
+ (void)showSuccessWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay;

/**  有内容的成功HUD 指定时间后回调*/
+ (void)showSuccessWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay completion:(void (^__nullable)(void))completion;

/**  没有内容的失败HUD 指定时间后回调*/
+ (void)showErrorWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay;

/**  有内容的失败HUD 指定时间后回调*/
+ (void)showWithInfoAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay completion:(void (^__nullable)(void))completion;

/** 有内容的HUD 指定时间后消失*/
+ (void)showWithInfoAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay;

/** 有背景的HUD 无法交互*/
+ (void)showWithActicity:(nullable NSString*)status;

@end
