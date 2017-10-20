//
//  RYDBaseController.m
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import "RYDBaseController.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "ViewController.h"

@interface RYDBaseController ()
{
    IQKeyboardReturnKeyHandler *_returnKeyHandler;
}
@end

@implementation RYDBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton new];
    
    [button setTitle:@"push" forState:UIControlStateNormal];
    
    [button setTitleColor:ColorOfBlack forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(100);
        
        make.center.equalTo(self.view);
        
    }];
}


- (void)buttonClick
{
    ViewController *vc = [ViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/* VC在导航中,该方法不执行.除非隐藏导航栏*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)addNavigationLeftItemWithTitle:(NSString*)title
{
    //左按钮
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    leftButton.titleLabel.font = fontSizeTitleBold;
    
    [leftButton setTitle:title forState:UIControlStateNormal];
    
    [leftButton sizeToFit];
    
    [leftButton setTitleColor:ColorOfBlack forState:UIControlStateNormal];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNavigationLeftItemWithImage:(UIImage*)image withSize:(CGSize)size
{
    //左按钮
    UIButton* leftButton = [[UIButton alloc] init];
    
    [leftButton setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [leftButton setImage:image forState:UIControlStateNormal];
    
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNavigationRightItemWithTitle:(NSString*)title
{
    //右按钮
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    rightButton.titleLabel.font = fontSizeTitleBold;
    
    [rightButton setTitle:title forState:UIControlStateNormal];
    
    [rightButton sizeToFit];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rightButton addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNavigationRightItemWithTitles:(NSArray<NSString *> *)titles
{
    NSMutableArray *rightBarItems = [NSMutableArray array];
    
    for (NSString *title in titles)
    {
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rightButton.titleLabel.font = fontSizeTitleBold;
        
        [rightButton setTitle:title forState:UIControlStateNormal];
        
        [rightButton sizeToFit];
        
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        [rightBarItems addObject:rightItem];
        
        [rightButton addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.navigationItem.rightBarButtonItems = rightBarItems;
}

- (void)addNavigationRightItemWithImage:(UIImage*)image withSize:(CGSize)size
{
    //右按钮
    UIButton* rightButton = [[UIButton alloc] init];
    
    [rightButton setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [rightButton setImage:image forState:UIControlStateNormal];
    
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rightButton addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftItemClick:(id)sender
{
    
}

- (void)rightItemClick:(id)sender
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)registerNibClass:(Class)cls forTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cls)];
}

- (void)addIQKeyboardHandler
{
    _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    
    _returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
