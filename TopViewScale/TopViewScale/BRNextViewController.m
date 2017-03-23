//
//  BRNextViewController.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRNextViewController.h"

#define kHeaderH 200
static NSString *cellID = @"cell";

@interface BRNextViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation BRNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 取消自动调整滚动视图间距 (ViewController + Nav 下会自动调整 tableView 的 contentInset)
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 显示导航栏（注：这里要设置显示动画，防止返回时出现导航栏覆盖当前页面）
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initUI {
    self.tableView.hidden = NO;
    self.headerView.hidden = NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // 注册单元格
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        // 设置表格的间距(上，左，下，右)
        _tableView.contentInset = UIEdgeInsetsMake(kHeaderH, 0, 0, 0);
        // 设置滚动指示器的间距（即滑动条的位置）
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderH)];
        _headerView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

@end
