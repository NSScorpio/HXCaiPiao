//
//  HXUserView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 28/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserView.h"
#import "HXUserHeaderView.h"
#import "HXUserOptionView.h"

@interface HXUserView () <HXUserHeaderViewDelegate, HXUserOptionViewDelegate>

@property (nonatomic, strong) HXUserHeaderView *headerView;
@property (nonatomic, strong) HXUserOptionView *optionView;

@end

@implementation HXUserView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI {
    [self addSubview:self.headerView];
    [self addSubview:self.optionView];

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(kScreen_Width * (0.5)));
    }];
    [self.optionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScreen_Width * 0.145));
    }];
}

#pragma mark - Public
- (void)updateAvatar:(UIImage *)avatar {
    if (!avatar) {
        return;
    }
    [self.headerView updateAvatar:avatar];
}
- (void)updateUserName:(NSString *)userName {
    if (!userName) {
        return;
    }
    [self.headerView updateUserName:userName];
}
- (void)createDataLabelsWithTitles:(NSArray<NSString *> *)titles {
    [self.headerView createDataLabelsWithTitles:titles];
}
- (void)updateData:(CGFloat)amount atIndex:(NSUInteger)index {
    [self.headerView updateData:amount atIndex:index];
}
- (void)createOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images {
    if (!titles || !images || titles.count != images.count ) {
        return;
    }
    [self.optionView createOptionsWithTitles:titles images:images];
}

#pragma mark - Delegate
#pragma mark HXUserHeaderViewDelegate
- (void)userHeaderViewDidSelectedAvatar {
    if ([self.delegate respondsToSelector:@selector(userViewDidSelectedAvatar)]) {
        [self.delegate userViewDidSelectedAvatar];
    }
}
- (void)userHeaderViewdIDselectedUserName {
    if ([self.delegate respondsToSelector:@selector(userViewdIDselectedUserName)]) {
        [self.delegate userViewdIDselectedUserName];
    }
}

#pragma mark HXUserOptionViewDelegate
- (void)userOptionViewDidSelectedOptionAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(userOptionViewDidSelectedOptionAtIndex:)]) {
        [self.delegate userOptionViewDidSelectedOptionAtIndex:index];
    }
}

#pragma mark - Getter
- (HXUserHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HXUserHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (HXUserOptionView *)optionView {
    if (!_optionView) {
        _optionView = [[HXUserOptionView alloc] init];
        _optionView.delegate = self;
    }
    return _optionView;
}

@end
