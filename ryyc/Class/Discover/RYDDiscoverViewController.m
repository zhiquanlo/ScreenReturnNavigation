//
//  RYDDiscoverViewController.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/17.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "RYDDiscoverViewController.h"

@interface RYDDiscoverViewController ()

@end

@implementation RYDDiscoverViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发现";
    self.view.backgroundColor = ColorOfRandom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
