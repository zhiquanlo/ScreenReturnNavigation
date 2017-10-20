//
//  RYDHomeViewController.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/17.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "RYDHomeViewController.h"

@interface RYDHomeViewController ()<UINavigationControllerDelegate>

@end

@implementation RYDHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    self.view.backgroundColor = ColorOfGrayTooLight;
    
    //[self addNavigationLeftItemWithTitle:@"push"];

    self.navigationController.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isHomePage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
