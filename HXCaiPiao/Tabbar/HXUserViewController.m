//
//  HXUserViewController.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserViewController.h"
#import "HXUserView.h"
#import "HXUserTableView.h"

@interface HXUserViewController () <HXUserViewDelegate>

@property (nonatomic, strong) HXUserView *userView;
@property (nonatomic, strong) HXUserTableView *tableView;

@end

@implementation HXUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}
- (void)buildUI {
    [self.view addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(kScreen_Width * (0.5 + 0.145)));
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
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self addKVO];
    
    _tableView.viewModel.dataSourceArray = @[@{HXTableViewIdleDataSourceDictionaryTitleKey : @"个人信息",
                                               HXTableViewIdleDataSourceDictionaryOptionIsShowKey : @(YES),
                                               HXTableViewIdleDataSourceDictionaryOptionTitlesKey : @[@"个人资料", @"购彩战绩", @"会员中心",@"个人资料", @"购彩战绩", @"会员中心"],
                                               HXTableViewIdleDataSourceDictionaryOptionImagesKey : @[[UIImage imageNamed:@"user_tboption_userinfo"],
                                                                                                      [UIImage imageNamed:@"user_tboption_record"],
                                                                                                      [UIImage imageNamed:@"user_tboption_memberCenter"],
                                                                                                      [UIImage imageNamed:@"user_tboption_userinfo"],
                                                                                                      [UIImage imageNamed:@"user_tboption_record"],
                                                                                                      [UIImage imageNamed:@"user_tboption_memberCenter"]]}.mutableCopy,
                                             @{HXTableViewIdleDataSourceDictionaryTitleKey : @"现金交易",
                                               HXTableViewIdleDataSourceDictionaryOptionIsShowKey : @(YES),
                                               HXTableViewIdleDataSourceDictionaryOptionTitlesKey : @[@"购彩记录", @"追号记录", @"账户明细", @"奖金增值"],
                                               HXTableViewIdleDataSourceDictionaryOptionImagesKey : @[[UIImage imageNamed:@"user_tboption_cashBuyHistory_red"],
                                                                                                      [UIImage imageNamed:@"user_tboption_cashTrackHistory_red"],
                                                                                                      [UIImage imageNamed:@"user_tboption_cashAcount_red"],
                                                                                                      [UIImage imageNamed:@"user_tboption_bonusIncrease"]]}.mutableCopy,
                                             @{HXTableViewIdleDataSourceDictionaryTitleKey : @"乐透交易",
                                               HXTableViewIdleDataSourceDictionaryOptionIsShowKey : @(YES),
                                               HXTableViewIdleDataSourceDictionaryOptionTitlesKey : @[@"购彩记录", @"追号记录", @"账户明细"],
                                               HXTableViewIdleDataSourceDictionaryOptionImagesKey : @[[UIImage imageNamed:@"user_tboption_goldBuyHistory"],
                                                                                                      [UIImage imageNamed:@"user_tboption_goldTrackHistory"],
                                                                                                      [UIImage imageNamed:@"user_tboption_goldAcount"]]}.mutableCopy,
                                             @{HXTableViewIdleDataSourceDictionaryTitleKey : @"华西特色",
                                               HXTableViewIdleDataSourceDictionaryOptionIsShowKey : @(YES),
                                               HXTableViewIdleDataSourceDictionaryOptionTitlesKey : @[@"华西荐单", @"单场竞猜", @"天天送8元"],
                                               HXTableViewIdleDataSourceDictionaryOptionImagesKey : @[[UIImage imageNamed:@"user_tboption_hxjd"],
                                                                                                      [UIImage imageNamed:@"user_tboption_singleMatchQuiz"],
                                                                                                      [UIImage imageNamed:@"user_tboption_sendEight"]]}.mutableCopy,
                                             @{HXTableViewIdleDataSourceDictionaryTitleKey : @"我的客服",
                                               HXTableViewIdleDataSourceDictionaryOptionIsShowKey : @(YES),
                                               HXTableViewIdleDataSourceDictionaryOptionTitlesKey : @[@"客服热线", @"在线客服", @"帮助中心"],
                                               HXTableViewIdleDataSourceDictionaryOptionImagesKey : @[[UIImage imageNamed:@"user_tboption_telNum"],
                                                                                                      [UIImage imageNamed:@"user_tboption_onlineService"],
                                                                                                      [UIImage imageNamed:@"user_tboption_helpCenter"]]}.mutableCopy].mutableCopy;
    
    _tableView.viewModel.requestStatus = HXTableViewRequestStatusRefreshSuccess;
}
- (void)dealloc {
    [self removeKVO];
}

#pragma mark - KVO
- (void)addKVO {
    [self.tableView.viewModel addObserver:self forKeyPath:@"requestStatus" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.tableView.viewModel addObserver:self forKeyPath:@"cellIndexPath" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.tableView.viewModel addObserver:self forKeyPath:@"cellHeightIndexPath" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.tableView.viewModel addObserver:self forKeyPath:@"cellDelegateEventIndexPath" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)removeKVO {
    [self.tableView.viewModel removeObserver:self forKeyPath:@"requestStatus"];
    [self.tableView.viewModel removeObserver:self forKeyPath:@"cellIndexPath"];
    [self.tableView.viewModel removeObserver:self forKeyPath:@"cellHeightIndexPath"];
    [self.tableView.viewModel removeObserver:self forKeyPath:@"cellDelegateEventIndexPath"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"requestStatus"]) {
        switch (self.tableView.viewModel.requestStatus) {
            case HXTableViewRequestStatusRefreshSuccess:
            case HXTableViewRequestStatusRefreshFailed:
            case HXTableViewRequestStatusLoadMoreSuccess:
            case HXTableViewRequestStatusLoadMoreFailed:
                break;
        }
    } else if ([keyPath isEqualToString:@"cellIndexPath"]) {
        [self.tableView configCell];
    } else if ([keyPath isEqualToString:@"cellHeightIndexPath"]) {
        [self.tableView configCellHeight];
    } else if ([keyPath isEqualToString:@"cellDelegateEventIndexPath"]) {
        [self.tableView eventHandler:^(HXUserTableViewEventType type, NSIndexPath *indexPath) {
            switch (type) {
                case HXUserTableViewEventTypeFlex: {
                    NSMutableDictionary *dict = self.tableView.viewModel.dataSourceArray[indexPath.row];
                    HXLog(@"Header Title : %@, isShow : %@", dict[HXTableViewIdleDataSourceDictionaryTitleKey], dict[HXTableViewIdleDataSourceDictionaryOptionIsShowKey]);
                    NSNumber *isShow = dict[HXTableViewIdleDataSourceDictionaryOptionIsShowKey];
                    if (isShow.boolValue) {
                        [self.tableView cellHideOptionsViewAtIndexPath:indexPath];
                    } else {
                        [self.tableView cellShowOptionsViewAtIndexPath:indexPath];
                    }
                    dict[HXTableViewIdleDataSourceDictionaryOptionIsShowKey] = @(!isShow.boolValue);
                    [self.tableView.viewModel.dataSourceArray replaceObjectAtIndex:indexPath.row withObject:dict];
                }
                    break;
                case HXUserTableViewEventTypeOption: {
                    NSDictionary *dict = self.tableView.viewModel.dataSourceArray[indexPath.section];
                    NSArray *titles = dict[HXTableViewIdleDataSourceDictionaryOptionTitlesKey];
                    HXLog(@"Title : %@", titles[indexPath.row]);
                }
                    break;
            }
            
        }];
    }
}

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
    HXLog(@"Option index : %ld", (unsigned long)index);
}

#pragma mark - Getter
- (HXUserView *)userView {
    if (!_userView) {
        _userView = [[HXUserView alloc] init];
        _userView.delegate = self;
    }
    return _userView;
}
- (HXUserTableView *)tableView {
    if (!_tableView) {
        _tableView = [[HXUserTableView alloc] init];
    }
    return _tableView;
}

@end
