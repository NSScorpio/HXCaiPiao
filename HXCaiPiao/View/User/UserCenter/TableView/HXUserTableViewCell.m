//
//  HXUserTableViewCell.m
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIView+Extension.h"

static const NSUInteger kOptionBtnBaseTag = 200;

@interface HXUserTableViewCell ()

@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UIView *sepLine;
@property (nonatomic, strong) UIScrollView *optionsScrollView;

@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, copy) NSArray<UIImage *> *images;

@property (nonatomic, assign, getter=isShowOption) BOOL showOption;

@end

@implementation HXUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI {    
    [self.contentView addSubview:self.headerBtn];
    [self.contentView addSubview:self.optionsScrollView];
    [self.contentView addSubview:self.sepLine];
    
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(kCommon_Margin);
        make.top.right.equalTo(self.contentView);
        make.height.equalTo(@(kScreen_Width * 0.1));
    }];
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBtn.mas_bottom);
        make.left.right.equalTo(self.headerBtn);
        make.height.equalTo(@0.5);
    }];
    [self.optionsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBtn.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(kScreen_Width * 0.16 + kCommon_Margin));
    }];
    
    _showOption = YES;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self configButtonStyle];
}
- (void)configButtonStyle {
    CGSize imageSize = self.headerBtn.imageView.size;
    CGSize titleSize = self.headerBtn.titleLabel.size;
    CGFloat spacing = self.headerBtn.frame.size.width - imageSize.width - titleSize.width;
    self.headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    self.headerBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing - kCommon_Margin * 2, 0.0, - titleSize.width);
    
    [self configButtonsInOptionScrollView:^(UIButton *button, NSUInteger index) {
        button.frame = CGRectMake(index * (kScreen_Width / 4),
                                  self.isShowOption ? 0 : - self.optionsScrollView.height - kCommon_Margin / 3,
                                  kScreen_Width / 4,
                                  self.optionsScrollView.height - kCommon_Margin / 3);
        CGSize imageSize = button.imageView.size;
        CGSize titleSize = button.titleLabel.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + kCommon_Margin/3), 0.0);
        titleSize = button.titleLabel.size;
        button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + kCommon_Margin/3), 0.0, 0.0, - titleSize.width);
    }];
    
    self.optionsScrollView.contentSize = CGSizeMake(kScreen_Width / 4 * self.titles.count, self.optionsScrollView.height);
}

#pragma mark - Public
- (void)updateHeaderTitleWithTitle:(NSString *)title {
    if (!title || 0 == title.length || [title isEqualToString:self.headerBtn.titleLabel.text]) {
        return;
    }
    [self.headerBtn setTitle:title forState:UIControlStateNormal];
}
- (void)updateOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images {
    if (!titles || !images || 0 == titles.count || 0 == images.count || titles.count != images.count ||
        [self.titles isEqualToArray:titles] || [self.images isEqualToArray:images]) {
        return;
    }
    
    for (NSUInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:Color_Text_Black forState:UIControlStateNormal];
        [btn setImage:images[i] forState:UIControlStateNormal];
        btn.titleLabel.font = Font_System_12;
        btn.tag = i + kOptionBtnBaseTag;
        [self.optionsScrollView addSubview:btn];
    }
    
    self.titles = [titles copy];
    self.images = [images copy];
    [self layoutIfNeeded];
}

- (void)showOptionsView {
    self.showOption = YES;
    [UIView animateWithDuration:kAnimation_Duration animations:^{
        [self configButtonsInOptionScrollView:^(UIButton *button, NSUInteger index) {
            button.top = 0;
        }];
        _optionsScrollView.alpha = 1.f;
    }];
}
- (void)hideOptionsView {
    self.showOption = NO;
    [UIView animateWithDuration:kAnimation_Duration animations:^{
        [self configButtonsInOptionScrollView:^(UIButton *button, NSUInteger index) {
            button.top = - button.height;
        }];
        _optionsScrollView.alpha = 0.f;
    }];
}

#pragma mark - Private
- (void)clickHeaderBtn:(UIButton *)btn {
    [UIView animateWithDuration:kAnimation_Duration animations:^{
        _headerBtn.imageView.transform = CGAffineTransformRotate(_headerBtn.imageView.transform, M_PI);
    }];
    
    if ([self.delegate respondsToSelector:@selector(cellDidSelectHeader:)]) {
        [self.delegate cellDidSelectHeader:self];
    }
}
- (void)clickOptionBtn:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(cell:didSelectOptionAtIndex:)]) {
        [self.delegate cell:self didSelectOptionAtIndex:btn.tag - kOptionBtnBaseTag];
    }
}

- (void)configButtonsInOptionScrollView:(void (^)(UIButton *button, NSUInteger index))block {
    for (NSUInteger i = 0; i < self.optionsScrollView.subviews.count; i++) {
        id btn = self.optionsScrollView.subviews[i];
        if (![btn isMemberOfClass:[UIButton class]]) {
            continue;
        }
        UIButton *button = (UIButton *)btn;
        if (block) block(button, i);
    }
}

#pragma mark - Getter
- (UIButton *)headerBtn {
    if (!_headerBtn) {
        _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.backgroundColor = [UIColor whiteColor];
        [_headerBtn setTitleColor:Color_Text_Black forState:UIControlStateNormal];
        [_headerBtn setImage:[UIImage imageNamed:@"common_down_arrow_gray"] forState:UIControlStateNormal];
        [_headerBtn addTarget:self action:@selector(clickHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        _headerBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _headerBtn.titleLabel.font = Font_System_17;
    }
    return _headerBtn;
}
- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = Color_Line_Sep;
    }
    return _sepLine;
}
- (UIScrollView *)optionsScrollView {
    if (!_optionsScrollView) {
        _optionsScrollView = [[UIScrollView alloc] init];
        _optionsScrollView.backgroundColor = Color_BG;
    }
    return _optionsScrollView;
}
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
