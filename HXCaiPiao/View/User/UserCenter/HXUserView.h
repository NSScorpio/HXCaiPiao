//
//  HXUserView.h
//  HXCaiPiao
//
//  Created by NSScorpio on 28/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  个人中心视图

#import "HXBaseView.h"

@protocol HXUserViewDelegate <NSObject>

- (void)userViewDidSelectedAvatar;
- (void)userViewdIDselectedUserName;
- (void)userOptionViewDidSelectedOptionAtIndex:(NSUInteger)index;

@end

@interface HXUserView : HXBaseView

@property (nonatomic, weak) id<HXUserViewDelegate> delegate;

/**
 更新头像
 */
- (void)updateAvatar:(UIImage *)avatar;

/**
 更新用户名
 */
- (void)updateUserName:(NSString *)userName;

/**
 创建展示的数据
 @param titles 数据标题
 */
- (void)createDataLabelsWithTitles:(NSArray<NSString *> *)titles;

/**
 更新标题对应的数据
 @param amount 数值
 @param index 标题下标
 */
- (void)updateData:(CGFloat)amount atIndex:(NSUInteger)index;

/**
 创建选项
 @param titles 标题
 @param images 图片
 */
- (void)createOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images;

@end
