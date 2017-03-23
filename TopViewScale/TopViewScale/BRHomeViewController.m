//
//  BRHomeViewController.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRNextViewController.h"

@interface BRHomeViewController ()

@end

@implementation BRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupNav];
}

- (void)setupNav {
    // 设置navigationBar的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"首页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(clickNextBtn)];
}

- (void)clickNextBtn {
    BRNextViewController *nextVC = [[BRNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end
