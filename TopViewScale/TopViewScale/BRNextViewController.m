//
//  BRNextViewController.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRNextViewController.h"
//#import <UIImageView+AFNetworking.h>
#import <UIImageView+YYWebImage.h>
#import <UIView+YYAdd.h>

// 屏幕大小、宽、高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kHeaderH 200
static NSString *cellID = @"cell";

@interface BRNextViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_headerView;
    UIView *_lineView;
    UIImageView *_headerImageView;
    UIStatusBarStyle _statusBarStyle; // 状态栏样式
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation BRNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 此行代码能将状态栏和导航栏字体颜色全体改变,只能是黑色或白色（不用考虑导航栏的存在）
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    _statusBarStyle = UIStatusBarStyleLightContent;
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

// 控制当前控制器状态栏颜色
// 注意：隐藏导航栏或没有导航栏时，此方法才会起作用。不然不能作用到当前的视图控制器上
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (void)initUI {
    self.tableView.hidden = NO;
    [self createHeaderView];
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

- (void)createHeaderView {
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderH)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = [UIColor orangeColor];
    // 设置contentMode （等比例填充）
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    // 设置图像裁切（裁切外部的）
    _headerImageView.clipsToBounds = YES;
    [_headerView addSubview:_headerImageView];
    
    // 设置分割线
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale; // 一个像素点
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _headerView.height - lineHeight, SCREEN_WIDTH, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    // 使用 AFNetworking 加载网络图片
    //[_headerImageView setImageWithURL:url];
    // 使用 YYWebImage 加载网络图片
    [_headerImageView setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + kHeaderH;
    NSLog(@"%f", offsetY);
    if (offsetY <= 0) {
        NSLog(@"下拉放大");
        _headerView.top = 0;
        _headerView.height = kHeaderH - offsetY;
        _headerImageView.alpha = 1;
        
    } else if (offsetY > 0) {
        NSLog(@"上滑整体移动");
        _headerView.height = kHeaderH;
       
        // headerImageView 的最小高度
        CGFloat minHeight = kHeaderH - 64;
        _headerView.top = -MIN(offsetY, minHeight);
        // 设置透明度
        CGFloat alpha = 1 - (offsetY / minHeight);
        _headerImageView.alpha = alpha;
        // 根据透明度来修改状态栏的颜色
        _statusBarStyle = alpha < 0.5 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        // 主动更新状态栏
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    // 设置图片的高度
    _headerImageView.height = _headerView.height;
    // 设置分割线的位置
    _lineView.top = _headerView.height - _lineView.height;
}

@end
