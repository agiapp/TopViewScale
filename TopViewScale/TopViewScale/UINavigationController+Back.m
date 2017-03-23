//
//  UINavigationController+Back.m
//  MyBaseProject
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UINavigationController+Back.h"
#import <objc/runtime.h>

@interface FullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation FullScreenPopGestureRecognizerDelegate

// 手势识别判断
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 如果是根视图控制器，取消手势（即没有可使用手势返回）
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    // 如果正在转场动画（KVC取值），取消手势
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    // 判断手指移动方向（从左往右拖时，才返回）
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end

@implementation UINavigationController (Back)

+ (void)load {
    // 黑魔法（交叉方法/交换方法）
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(br_pushViewController:animated:));
    // 把自己写的 br_push.. 方法和系统的 push.. 方法进行交换
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)br_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 从所有的交互手势 数组中查找，如果没有我们自定义的手势就添加
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.br_popGestureRecognizer]) {
        // 添加我们的定义的交互手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.br_popGestureRecognizer];
        
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        // 拦截所有的系统手势方法 handleNavigationTransition
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.br_popGestureRecognizer.delegate = [self br_fullScreenPopGestureRecognizerDelegate];
        [self.br_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // 禁用系统的交互手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self br_pushViewController:viewController animated:animated];
    }
}

- (FullScreenPopGestureRecognizerDelegate *)br_fullScreenPopGestureRecognizerDelegate {
    FullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[FullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}
//懒加载 初始化UIPanGestureRecognizer交互手势 （我们自定义的一个交互手势）
- (UIPanGestureRecognizer *)br_popGestureRecognizer {
    // 通过运行时的关联对象，直接把手势添加到 NavigationController 上
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        //分类中使用 运行时关联对象 添加属性
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end
