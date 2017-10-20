//
//  UIImage+imageName.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "UIImage+imageName.h"


@implementation UIImage (imageName)

+(UIImage *)imageWithOriginalMode:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

//通过颜色来生成一个纯色图片
+ (UIImage *)ImageFromColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height {
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//通过一个View生成一张图片
#pragma mark 生成image
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size 
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
#pragma mark - 根据颜色生成一个渐变背景色的View
+(UIImage *)setUpViewGradientEffectWithStartColor:(UIColor *)startColor1 addStartColor:(UIColor *)startColor2 addSiaze:(CGSize)size
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)startColor1.CGColor,(__bridge id)startColor2.CGColor];
    //位置x,y    自己根据需求进行设置  使其从不同位置进行渐变
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [view.layer addSublayer:gradientLayer];
    
    UIImage *image = [UIImage makeImageWithView:view withSize:CGSizeMake(size.width, size.height)];
    return image;
    
}

@end
