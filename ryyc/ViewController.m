//
//  ViewController.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/17.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"push";
    
    self.view.backgroundColor = ColorOfWhite;
    
    //可以解决push或者pop时导航栏显示不全的问题
    self.extendedLayoutIncludesOpaqueBars = YES;//不透明的条下是否可以扩展
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
