//
//  HXBaseViewController.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXBaseViewController.h"

@interface HXBaseViewController ()

@end

@implementation HXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSettings];
}
- (void)configSettings {
    self.view.backgroundColor = Color_BG;
    
    // 设置导航栏返回按钮
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
}

#pragma mark - KVO

#pragma mark - Public

#pragma mark - Private

#pragma mark - Delegate

#pragma mark - Setter

#pragma mark - Getter

@end
