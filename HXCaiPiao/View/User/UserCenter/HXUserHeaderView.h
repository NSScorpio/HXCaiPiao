//
//  HXUserHeaderView.h
//  HXCaiPiao
//
//  Created by NSScorpio on 28/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  个人中心顶部

#import "HXBaseView.h"

@protocol HXUserHeaderViewDelegate <NSObject>

- (void)userHeaderViewDidSelectedAvatar;
- (void)userHeaderViewdIDselectedUserName;

@end

@interface HXUserHeaderView : HXBaseView

@property (nonatomic, weak) id<HXUserHeaderViewDelegate> delegate;

- (void)updateAvatar:(UIImage *)avatar;
- (void)updateUserName:(NSString *)userName;

- (void)createDataLabelsWithTitles:(NSArray<NSString *> *)titles;
- (void)updateData:(CGFloat)amount atIndex:(NSUInteger)index;

@end
