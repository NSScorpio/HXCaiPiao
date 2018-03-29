//
//  HXUserOptionView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 29/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserOptionView.h"

@interface HXUserOptionView ()

@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, copy) NSArray<UIImage *> *images;

@end

@implementation HXUserOptionView

#pragma mark - Public
- (void)createOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images {
    if (!titles || !images || 0 == titles.count || 0 == images.count || titles.count != images.count ||
        [self.titles isEqualToArray:titles] || [self.images isEqualToArray:images]) {
        return;
    }
    
    UIButton *tmpBtn = nil;
    for (NSUInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:Color_Text_Black forState:UIControlStateNormal];
        [btn setImage:images[i] forState:UIControlStateNormal];
        btn.titleLabel.font = Font_System_17;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - 1.5 * kCommon_Margin / 2);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, - 1.5 * kCommon_Margin / 2, 0.0, 0.0);
        btn.layer.cornerRadius = 3.f * kScreen_Ratio;
        btn.layer.borderColor = [Color_Main colorWithAlphaComponent: 0.3].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.tag = i;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                make.left.equalTo(self).with.offset(kCommon_Margin);
            } else {
                make.left.equalTo(tmpBtn.mas_right).with.offset(kCommon_Margin);
            }
            make.top.equalTo(self).with.offset(kCommon_Margin / 2);
            make.bottom.equalTo(self).with.offset(- kCommon_Margin / 2);
            make.width.equalTo(@((kScreen_Width - kCommon_Margin * (titles.count + 1)) / titles.count));
        }];
        tmpBtn = btn;
    }
    self.titles = [titles copy];
    self.images = [images copy];
}

#pragma mark - Private
- (void)clickBtn:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(userOptionViewDidSelectedOptionAtIndex:)]) {
        [self.delegate userOptionViewDidSelectedOptionAtIndex:btn.tag];
    }
}

#pragma mark - Getter
- (NSArray<NSString *> *)titles {
    if (!_titles) {
        _titles = @[];
    }
    return _titles;
}
- (NSArray<UIImage *> *)images {
    if (!_images) {
        _images = @[];
    }
    return _images;
}
@end
