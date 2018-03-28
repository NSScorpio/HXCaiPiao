//
//  HXBaseTabBarController.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXBaseTabBarController.h"
#import "HXHomePageViewController.h"
#import "HXHeadlineNewsViewController.h"
#import "HXUserViewController.h"
#import "HXBaseNavigationController.h"

@interface HXBaseTabBarController ()

@end

@implementation HXBaseTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addViewControllers];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)addViewControllers {
    UIGraphicsBeginImageContext(CGSizeMake(kScreen_Width, 49));
    // 首页
    HXHomePageViewController *homeVC = [[HXHomePageViewController alloc] init];
    HXBaseNavigationController *homeNavi = [self createNaviWithViewController:homeVC title:@"首页" imageName:@"tab_home" selectedImageName:@"tab_home_select"];
    
    // 头条新闻
    HXHeadlineNewsViewController *headlineNewsVC = [[HXHeadlineNewsViewController alloc] init];
    HXBaseNavigationController *headlineNewsNavi = [self createNaviWithViewController:headlineNewsVC title:@"头条新闻" imageName:@"tab_headline" selectedImageName:@"tab_headline_select"];
    
    // 用户中心
    HXUserViewController *userVC = [[HXUserViewController alloc] init];
    HXBaseNavigationController *userNavi = [self createNaviWithViewController:userVC title:@"个人中心" imageName:@"tab_user" selectedImageName:@"tab_user_select"];
    userNavi.transparent = YES;
    UIGraphicsEndImageContext();
    
    self.viewControllers = @[homeNavi, headlineNewsNavi, userNavi];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_RGB(135, 135, 135)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_Main} forState:UIControlStateSelected];
    
    // 设置背景颜色
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTranslucent:NO];
}

- (HXBaseNavigationController *)createNaviWithViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    HXBaseNavigationController *navi = [[HXBaseNavigationController alloc] initWithRootViewController:viewController];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    viewController.title = title;
    return navi;
}

@end
