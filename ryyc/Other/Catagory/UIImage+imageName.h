//
//  UIImage+imageName.h
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (imageName)
//生成一张不被渲染的图片
+(UIImage *)imageWithOriginalMode:(NSString *)name;


//通过颜色来生成一个纯色图片
+ (UIImage *)ImageFromColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;

//通过一个View生成一张渐变色的图片
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size ;

//通过给定的颜色和尺寸生成一张渐变色的图片
+(UIImage *)setUpViewGradientEffectWithStartColor:(UIColor *)startColor1 addStartColor:(UIColor *)startColor2 addSiaze:(CGSize)size;

@end
