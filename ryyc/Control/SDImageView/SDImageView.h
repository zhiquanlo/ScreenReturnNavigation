//
//  SDImageView.h
//  加载网络图片
//
//  Created by 吴世宇 on 15/3/25.
//  Copyright (c) 2015年 吴世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDImageView : UIImageView

@property (nonatomic, strong) NSString *defaultIMG;//默认图片
@property (nonatomic, strong) NSString *imageURL;//网络图片url

@end
