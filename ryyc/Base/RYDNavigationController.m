//
//  RYDNavigationController.m
//  YouCai
//
//  Created by mini on 17/3/16.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "RYDNavigationController.h"

@interface RYDNavigationController ()

@property(nonatomic,strong) id interactive;
@end

@implementation RYDNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 导航背景*/
    UIImage *image = [ImageHandler imageWithColor:ColorOfOrange];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [[UINavigationBar appearance] setTintColor:ColorOfWhite];
    
    /* 导航标题*/
    NSDictionary *titleAttri = @{ NSForegroundColorAttributeName:ColorOfWhite, NSFontAttributeName:fontSizeTitlePlus };
    
    [self.navigationBar setTitleTextAttributes:titleAttri];
    
    self.extendedLayoutIncludesOpaqueBars = YES;//不透明的条下是否可以扩展

    self.automaticallyAdjustsScrollViewInsets = NO;//自动校准滚动视图的嵌入视图

    self.navigationBar.translucent = NO;//是否半透明
    
    /* 状态栏白色*/
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    
    temporaryBarButtonItem.title = @"";
    
    viewController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    [super pushViewController:viewController animated:YES];
}

@end
