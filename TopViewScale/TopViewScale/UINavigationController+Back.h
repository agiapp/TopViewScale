//
//  UINavigationController+Back.h
//  MyBaseProject
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Back)
/// 自定义全屏拖拽返回手势
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *br_popGestureRecognizer;

@end
