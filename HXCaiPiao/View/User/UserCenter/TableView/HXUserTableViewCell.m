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
        make.left.right.bottom.equalTo(self.contentView);
    }];
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
        
    for (NSInteger i = 0; i < self.optionsScrollView.subviews.count; i++) {
        id btn = self.optionsScrollView.subviews[i];
        if (![btn isKindOfClass:[UIButton class]]) {
            break;
        }
        UIButton *button = (UIButton *)btn;
        CGSize imageSize = button.imageView.size;
        CGSize titleSize = button.titleLabel.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + kCommon_Margin/3), 0.0);
        titleSize = button.titleLabel.size;
        button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + kCommon_Margin/3), 0.0, 0.0, - titleSize.width);
    }
    
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
    
    UIButton *tmpBtn = nil;
    for (NSUInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:Color_Text_Black forState:UIControlStateNormal];
        [btn setImage:images[i] forState:UIControlStateNormal];
        btn.titleLabel.font = Font_System_12;
        btn.tag = i + kOptionBtnBaseTag;
        btn.frame = CGRectMake(i * (kScreen_Width / 4), 0, kScreen_Width / 4, 200);
        [self.optionsScrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                make.left.equalTo(self.optionsScrollView);
            } else {
                make.left.equalTo(tmpBtn.mas_right);
            }
            make.top.equalTo(self.optionsScrollView);
            make.bottom.equalTo(self).with.offset(- kCommon_Margin / 3);
            make.width.equalTo(@(kScreen_Width / 4));
        }];
        tmpBtn = btn;
    }
    
    self.titles = [titles copy];
    self.images = [images copy];
    [self layoutIfNeeded];
}

#pragma mark - Private
- (void)clickHeaderBtn:(UIButton *)btn {
    [UIView animateWithDuration:kAnimation_Duration animations:^{
        self.headerBtn.imageView.transform = CGAffineTransformRotate(self.headerBtn.imageView.transform, M_PI);
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
