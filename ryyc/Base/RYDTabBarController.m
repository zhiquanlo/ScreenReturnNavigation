//
//  RYDTabBarController.m
//  YouCai
//
//  Created by mini on 17/3/16.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "RYDTabBarController.h"
#import "RYDHomeViewController.h"
#import "RYDShequViewController.h"
#import "RYDDiscoverViewController.h"
#import "RYDMineViewController.h"
#import "RYDNavigationController.h"
#import "UIImage+imageName.h"


@interface RYDTabBarController ()

@end

@implementation RYDTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //添加子控制器
    [self setUpChildViewController];
    
    //设置tabar的按钮标题
    [self setUpTabBarBtnTitle];
}

-(void)setUpTabBarBtnTitle
{
    NSArray *title = @[@"首页", @"社区", @"发现", @"我的"];
    
    NSUInteger index = 0;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
    textAttrs[NSForegroundColorAttributeName] = UIColorFromHex(0x989898);
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    for (UIViewController *vc in self.childViewControllers)
    {
        vc.tabBarItem.title = title[index];
        
        NSString *unSelectTitle = [NSString stringWithFormat:@"%@_未选中",title[index]];
        
        NSString *selectTitle = [NSString stringWithFormat:@"%@_选中",title[index]];
        
        vc.tabBarItem.image = [UIImage imageWithOriginalMode:unSelectTitle];
        
        vc.tabBarItem.selectedImage = [UIImage imageWithOriginalMode:selectTitle];
        
        [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        [vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        
        index++;
    }
    
 }

-(void)setUpChildViewController
{
    //    首页
    RYDHomeViewController *HomeVC = [[RYDHomeViewController alloc] init];
    
    RYDNavigationController *naVC1 = [[RYDNavigationController alloc] initWithRootViewController:HomeVC];
    
    [self addChildViewController:naVC1];

    //社区
    RYDShequViewController *shequVC = [[RYDShequViewController alloc] init];
    
    RYDNavigationController *naVC2 = [[RYDNavigationController alloc] initWithRootViewController:shequVC];
    
    [self addChildViewController:naVC2];

    //发现
    RYDDiscoverViewController *discoverVc = [[RYDDiscoverViewController alloc] init];
    
    RYDNavigationController *naVC3 = [[RYDNavigationController alloc] initWithRootViewController:discoverVc];
    
    [self addChildViewController:naVC3];

    //我的
    RYDMineViewController *mineVC = [[RYDMineViewController alloc] init];
    
    RYDNavigationController *naVC4 = [[RYDNavigationController alloc] initWithRootViewController:mineVC];
    
    [self addChildViewController:naVC4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
