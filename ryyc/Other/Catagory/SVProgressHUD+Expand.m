//
//  SVProgressHUD+Expand.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "SVProgressHUD+Expand.h"

@implementation SVProgressHUD (Expand)

//
+ (void)showSuccessWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay completion:(void (^)(void))completion {
    [self showImage:[self sharedView].successImage status:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissWithDelay:delay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

//
+ (void)showSuccessWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay {
    [self showImage:[self sharedView].successImage status:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissWithDelay:delay];
}

//
+ (void)showErrorWithStatusAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay {
    [self showImage:[self sharedView].errorImage status:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissWithDelay:delay];
}

+ (void)showWithInfoAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay completion:(void (^)(void))completion {
    [self showInfoWithStatus:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissWithDelay:delay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

//
+ (void)showWithInfoAndDismissDelay:(nullable NSString*)status delay:(NSTimeInterval)delay {
    [self showInfoWithStatus:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissWithDelay:delay];
}

//
+ (void)showWithActicity:(nullable NSString*)status {
    [self showWithStatus:status];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

@end
