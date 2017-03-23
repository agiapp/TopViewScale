//
//  BRHomeViewController.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRHomeViewController.h"

@interface BRHomeViewController ()

@end

@implementation BRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(clickNextBtn)];
}

- (void)clickNextBtn {
    
}


@end
