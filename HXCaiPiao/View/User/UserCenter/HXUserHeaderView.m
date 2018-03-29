//
//  HXUserHeaderView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 28/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserHeaderView.h"

static const NSUInteger kDataLbBaseTag = 100;

@interface HXUserHeaderView ()

@property (nonatomic, strong) UIButton *avatarBtn;
@property (nonatomic, strong) UILabel *userNameLb;

@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, strong) UIView *dataLbsView;

@end

@implementation HXUserHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"user_header_bg"];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(kScreen_Width * 0.5));
    }];
    
    UIView *avatarBgView = [[UIView alloc] init];
    UITapGestureRecognizer *tapGrz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvatarBgView)];
    [avatarBgView addGestureRecognizer:tapGrz];
    [self addSubview:avatarBgView];
    [avatarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self.mas_bottom).with.offset(- 90 * kScreen_Ratio);
        make.height.equalTo(@(50 * kScreen_Ratio));
    }];
    
    [avatarBgView addSubview:self.avatarBtn];
    [avatarBgView addSubview:self.userNameLb];
    [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(avatarBgView);
        make.left.equalTo(avatarBgView).with.offset(2 * kCommon_Margin);
        make.width.equalTo(avatarBgView.mas_height);
    }];
    [self.userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarBtn.mas_right).with.offset(1.5 * kCommon_Margin);
        make.centerY.equalTo(avatarBgView);
    }];
     
    UIImageView *rightArrowImgView = [[UIImageView alloc] init];
    rightArrowImgView.image = [UIImage imageNamed:@"common_right_arrow_white"];
    [avatarBgView addSubview:rightArrowImgView];
    [rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(avatarBgView).with.offset(- 1.5 * kCommon_Margin);
        make.centerY.equalTo(avatarBgView);
    }];
    
    // 用户展示数据
    [self addSubview:self.dataLbsView];
    [self.dataLbsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarBgView.mas_bottom).with.offset(kCommon_Margin);
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - Public
- (void)updateAvatar:(UIImage *)avatar {
    if (!avatar) {
        return;
    }
    [self.avatarBtn setBackgroundImage:avatar forState:UIControlStateNormal];
}
- (void)updateUserName:(NSString *)userName {
    if (!userName) {
        return;
    }
    self.userNameLb.text = userName;
}
- (void)createDataLabelsWithTitles:(NSArray<NSString *> *)titles {
    if (!titles || 0 == titles.count || [self.titles isEqualToArray:titles]) {
        return;
    }
    
    UILabel *tmpLb = nil;
    for (NSUInteger i = 0; i < titles.count; i++) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        titleLb.font = Font_System_15;
        titleLb.text = titles[i];
        titleLb.textAlignment = NSTextAlignmentCenter;
        
        [self.dataLbsView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                make.left.equalTo(self.dataLbsView);
            } else {
                make.left.equalTo(tmpLb.mas_right);
            }
            make.top.equalTo(self.dataLbsView);
            make.bottom.equalTo(self.dataLbsView.mas_centerY);
            make.width.equalTo(@(kScreen_Width / titles.count));
        }];
        tmpLb = titleLb;
    }
    
    for (NSUInteger i = 0; i < titles.count; i++) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.textColor = [UIColor whiteColor];
        titleLb.font = Font_System_15;
        titleLb.text = @"--";
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.tag = i + kDataLbBaseTag;
        
        [self.dataLbsView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                make.left.equalTo(self.dataLbsView);
            } else {
                make.left.equalTo(tmpLb.mas_right);
            }
            make.top.equalTo(self.dataLbsView.mas_centerY);
            make.bottom.equalTo(self.dataLbsView);
            make.width.equalTo(@(kScreen_Width / titles.count));
        }];
        tmpLb = titleLb;
    }
}
- (void)updateData:(CGFloat)amount atIndex:(NSUInteger)index {
    UILabel *amountLb = [self.dataLbsView viewWithTag:index + kDataLbBaseTag];
    if (!amountLb || ![amountLb isMemberOfClass:[UILabel class]]) {
        return;
    }
#warning Unit
    amountLb.text = [NSString stringWithFormat:@"%.f", amount];
}

#pragma mark - Private
- (void)clickAvatarBtn {
    if ([self.delegate respondsToSelector:@selector(userHeaderViewDidSelectedAvatar)]) {
        [self.delegate userHeaderViewDidSelectedAvatar];
    }
}
- (void)clickAvatarBgView {
    if ([self.delegate respondsToSelector:@selector(userHeaderViewdIDselectedUserName)]) {
        [self.delegate userHeaderViewdIDselectedUserName];
    }
}

#pragma mark - Getter
- (UIButton *)avatarBtn {
    if (!_avatarBtn) {
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_avatarBtn addTarget:self action:@selector(clickAvatarBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarBtn;
}
- (UILabel *)userNameLb {
    if (!_userNameLb) {
        _userNameLb = [[UILabel alloc] init];
        _userNameLb.textColor = [UIColor whiteColor];
        _userNameLb.font = Font_System_15;
    }
    return _userNameLb;
}
- (NSArray<NSString *> *)titles {
    if (!_titles) {
        _titles = @[];
    }
    return _titles;
}
- (UIView *)dataLbsView {
    if (!_dataLbsView) {
        _dataLbsView = [[UIView alloc] init];
    }
    return _dataLbsView;
}

@end
