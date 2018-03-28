//
//  HXBaseNavigationController.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXBaseNavigationController.h"

@interface HXBaseNavigationController ()

@end

@implementation HXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

#pragma mark - UI
- (void)buildUI {
    // 导航栏背景
    CGRect rect = CGRectMake(0, 0, kScreen_Width, kNavi_Height);
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, Color_Main.CGColor);
    CGContextFillRect(context, rect);
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    // 处理导航栏下方的黑线
    CGRect lineRect = CGRectMake(0, 0, kScreen_Width, 1);
    UIGraphicsBeginImageContext(lineRect.size);
    CGContextRef lineContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(lineContext, Color_Main.CGColor);
    CGContextFillRect(lineContext, lineRect);
    UIImage *lineImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setShadowImage:lineImage];
    
    // 文字
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = dict;
}

#pragma mark - Rewrite
// 重写 pushViewController 方法, push 后隐藏 tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (1 == self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
#pragma mark - Setter
- (void)setTransparent:(BOOL)transparent {
    _transparent = transparent;
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

@end
