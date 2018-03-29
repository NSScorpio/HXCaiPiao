//
//  HXUserOptionView.h
//  HXCaiPiao
//
//  Created by NSScorpio on 29/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  个人中心充值、提现、优惠选项栏

#import "HXBaseView.h"

@protocol HXUserOptionViewDelegate <NSObject>

- (void)userOptionViewDidSelectedOptionAtIndex:(NSUInteger)index;

@end

@interface HXUserOptionView : HXBaseView

@property (nonatomic, weak) id<HXUserOptionViewDelegate> delegate;

- (void)createOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images;

@end
