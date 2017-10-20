//
//  RYDBaseController.h
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYDBaseController : UIViewController

- (void)addNavigationLeftItemWithTitle:(NSString*)title;

- (void)addNavigationLeftItemWithImage:(UIImage*)image withSize:(CGSize)size;

- (void)addNavigationRightItemWithTitle:(NSString*)title;

- (void)addNavigationRightItemWithTitles:(NSArray<NSString *> *)titles;

- (void)addNavigationRightItemWithImage:(UIImage*)image withSize:(CGSize)size;

- (void)leftItemClick:(id)sender;

- (void)rightItemClick:(id)sender;

- (void)registerNibClass:(Class)cls forTableView:(UITableView *)tableView;

- (void)addIQKeyboardHandler;

@end
