//
//  HXUserViewController.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserViewController.h"
#import "HXUserView.h"

@interface HXUserViewController () <HXUserViewDelegate>

@property (nonatomic, strong) HXUserView *userView;

@end

@implementation HXUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    [self.view addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [self.userView updateAvatar:[UIImage imageNamed:@"user_avatar_default"]];
    [self.userView updateUserName:@"注册/登录"];
    NSArray *dataTitles = @[@"现金(元)", @"彩金(元)", @"金币", @"乐豆"];
    [self.userView createDataLabelsWithTitles:dataTitles];
    NSArray *btnTitles = @[@"充值", @"提现", @"优惠券"];
    NSArray *images = @[[UIImage imageNamed:@"user_option_recharge"],
                        [UIImage imageNamed:@"user_option_withdraw"],
                        [UIImage imageNamed:@"user_option_coupon"]];
    [self.userView createOptionsWithTitles:btnTitles images:images];
}

#pragma mark - KVO

#pragma mark - Public

#pragma mark - Private

#pragma mark - Delegate
#pragma mark HXUserViewDelegate
#warning TODO
- (void)userViewDidSelectedAvatar {
    HXLog(@"Avator");
}
- (void)userViewdIDselectedUserName {
    HXLog(@"User Name");
}
- (void)userOptionViewDidSelectedOptionAtIndex:(NSUInteger)index {
    HXLog(@"Option index : %ld", index);
}

#pragma mark - Setter

#pragma mark - Getter
- (HXUserView *)userView {
    if (!_userView) {
        _userView = [[HXUserView alloc] init];
        _userView.delegate = self;
    }
    return _userView;
}

@end
