//
//  HXTableViewModel.m
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXTableViewModel.h"

@implementation HXTableViewModel
- (instancetype)init {
    return [self initWithDefaultValue];
}
- (instancetype)initWithDefaultValue {
    if (self = [super init]) {
        [self buildDefaultValue];
    }
    return self;
}
- (void)buildDefaultValue {
    self.dataSourceArray = @[].mutableCopy;
    
    self.closeRefresh = NO;
    self.autoRefresh = YES;
    
    self.backgroundColor = [UIColor whiteColor];
    self.cellBackgroundColor = [UIColor whiteColor];
    
    self.refreshingHeaderStateLabelFont = Font_System_15;
    self.refreshingHeaderStateLabelTextColor = Color_Text_Gray;
    self.refreshingHeaderTitleIdleText = @"下拉可以刷新";
    self.refreshingHeaderTitlePullingText = @"松开立即刷新";
    self.refreshingHeaderTitleRefreshingText = @"正在刷新中...";
    
    self.refreshingFooterStateLabelFont = Font_System_15;
    self.refreshingFooterStateLabelTextColor = Color_Text_Gray;
    self.refreshingFooterTitleIdleText = @"上拉加载更多";
    self.refreshingFooterTitleRefreshingText = @"正在加载...";
    self.refreshingFooterTitleNoMoreDataText = @"没有更多数据";
}


@end
