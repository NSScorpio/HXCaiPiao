//
//  HXUserTableViewCell.h
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  个人中心列表cell

#import <UIKit/UIKit.h>

@class HXUserTableViewCell;

@protocol HXUserTableViewCellDelegate <NSObject>

- (void)cellDidSelectHeader:(HXUserTableViewCell *)cell;
- (void)cell:(HXUserTableViewCell *)cell didSelectOptionAtIndex:(NSInteger)index;

@end

@interface HXUserTableViewCell : UITableViewCell

@property (nonatomic, weak) id<HXUserTableViewCellDelegate> delegate;

//@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)updateHeaderTitleWithTitle:(NSString *)title;
- (void)updateOptionsWithTitles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images;

@end
