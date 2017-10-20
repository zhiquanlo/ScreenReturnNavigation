//
//  ImageHandler.h
//  图片处理类
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHandler : NSObject


/** 重绘图片尺寸*/
+ (UIImage *)reSizeImage:(UIImage *)image targetSize:(CGSize)reSize;



/**  颜色转换为背景图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;



/**
 将控件转化成图片
 
 @param view 需要转换的控件
 @return return value description
 */
+ (UIImage *)imageForView:(UIView *)view;


/**
 上传前的压缩
 
 @param image 图片
 @return 压缩后的NSData
 */
+ (NSData *)compressImageData:(UIImage*)image;



/**
 根据指定大小循环逼近
 
 @param image 图片
 @param maxLength 指定大小
 @return 压缩后图片
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;



/**
 根据指定宽高等比缩放

 @param originalImage 图片
 @param size 指定大小
 @return 压缩后图片
 */
+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;





/** 根据宽高最大的一方自动压缩，*/
+ (UIImage *)imageCompressForAuto:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


/**
 旋转图片

 @param image 图片
 @param rotation 角度
 @return 旋转后图片
 */
+ (UIImage *)rotateImage:(UIImage *)image orientation:(UIImageOrientation)rotation;




@end
