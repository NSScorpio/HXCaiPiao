//
//  HXUserTableView.h
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  个人中心列表

#import "HXTableView.h"

typedef NS_ENUM(NSUInteger, HXUserTableViewEventType) {
    HXUserTableViewEventTypeFlex,   // 伸缩
    HXUserTableViewEventTypeOption  // 选项
};

extern NSString *const HXTableViewIdleDataSourceDictionaryTitleKey;
extern NSString *const HXTableViewIdleDataSourceDictionaryOptionTitlesKey;
extern NSString *const HXTableViewIdleDataSourceDictionaryOptionImagesKey;
extern NSString *const HXTableViewIdleDataSourceDictionaryOptionIsShowKey;

@interface HXUserTableView : HXTableView

- (void)configCell;
- (void)configCellHeight;

- (void)cellShowOptionsViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)cellHideOptionsViewAtIndexPath:(NSIndexPath *)indexPath;

- (void)eventHandler:(void (^)(HXUserTableViewEventType type, NSIndexPath *indexPath))handler;

@end
