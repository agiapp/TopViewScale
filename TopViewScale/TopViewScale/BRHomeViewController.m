//
//  BRHomeViewController.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRNextViewController.h"

@interface BRHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation BRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.hidden = NO;
}

- (void)setupNav {
    self.navigationItem.title = @"首页";
    // 设置navigationBar的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(clickNextBtn)];
}

- (void)clickNextBtn {
    BRNextViewController *nextVC = [[BRNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (UITableView *)tableView {
    if (!_tableView) {
        // 分组样式，始末单元格分割线左对齐
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //在使用UITableViewStyleGrouped类型UITableView的时候，要想去掉头部默认高度。
        //_tableView.tableFooterView = [UIView new]; //注意：这行代码不能放在上面两句设置代理的前面，否则不能设置头部默认高度
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"分组样式"];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    // 去掉UITableViewStyleGrouped类型UITableView头部默认高度：设置分区头无穷小
    // 这里不能直接设置为0，通常设置为一个趋近于0的数
    return CGFLOAT_MIN; // 无穷小：0.00000000..1
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}


/**
    
 总结：
    UITableViewStyleGrouped类型UITableView
    去掉分区头/分区尾的高度：不能直接设置为0，用 CGFLOAT_MIN（无穷小）来代替
 
    UITableViewStylePlain (普通样式)
    UITableViewStyleGrouped (分组样式)
    两者区别：
        1. 去掉分区头、分区尾高度
            普通样式 去掉分区头和分区尾高度可以直接设置0
            分组样式 去掉分区头和分区尾高度直接设置0不会有效果，通常用 CGFLOAT_MIN（无穷小）来代替
        2. 分区头、分区尾的黏性
 
 */


@end
