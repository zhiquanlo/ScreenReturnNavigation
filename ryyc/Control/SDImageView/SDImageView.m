//
//  SDImageView.m
//  加载网络图片
//
//  Created by 吴世宇 on 15/3/25.
//  Copyright (c) 2015年 吴世宇. All rights reserved.
//

#import "SDImageView.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@implementation SDImageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    }
    return self;
}

/**
 @功能：加载网络图片
 @参数：imageURL
 @返回值：无
 */
- (void)setImageURL:(NSString *)imageURL
{
    if (_imageURL != imageURL)
    {
        _imageURL = imageURL;
        if (!_imageURL) return;
        
        [self sd_setImageWithURL:[NSURL URLWithString:self.imageURL]
                placeholderImage:[UIImage imageNamed:self.defaultIMG]
                         options:SDWebImageAllowInvalidSSLCertificates];
        
    }
    
}

@end
