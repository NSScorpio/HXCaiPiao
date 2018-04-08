//
//  HXTableViewModel.h
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  ViewModel

#import <UIKit/UIKit.h>

// 刷新状态
typedef NS_ENUM(NSUInteger, HXTableViewRefreshingStatus) {
    HXTableViewRefreshingStatusRefresh, // 下拉
    HXTableViewRefreshingStatusLoadMore // 加载更多
};
// 请求状态
typedef NS_ENUM(NSUInteger, HXTableViewRequestStatus) {
    HXTableViewRequestStatusRefreshSuccess,  // 下拉刷新成功
    HXTableViewRequestStatusRefreshFailed,   // 下拉刷新失败
    HXTableViewRequestStatusLoadMoreSuccess, // 加载更多成功
    HXTableViewRequestStatusLoadMoreFailed   // 加载更多失败
};

@interface HXTableViewModel : NSObject

#pragma mark - Basic
@property (nonatomic, assign) NSUInteger type; // 类型
@property (nonatomic, strong) NSMutableArray *dataSourceArray; // 展示的数据

@property (nonatomic, strong) UIColor *backgroundColor;     // tableview 的背景颜色
@property (nonatomic, strong) UIColor *cellBackgroundColor; // cell 的背景颜色

#pragma mark - TableView Delegate
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *cellReuseIdentifier;

@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, strong) NSIndexPath *cellHeightIndexPath;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSIndexPath *cellSelectIndexPath; // tableView didSelect方法中的indexPath

@property (nonatomic, strong) NSIndexPath *cellDelegateEventIndexPath; // cell点击事件所在的indexPath

#pragma mark - Status
@property (nonatomic, assign) HXTableViewRequestStatus requestStatus;       // 请求状态
@property (nonatomic, assign) HXTableViewRefreshingStatus refreshingStatus; // 刷新状态

@property (nonatomic, assign, getter=isCloseRefresh) BOOL closeRefresh; // 是否关闭下拉刷新、加载更多
@property (nonatomic, assign, getter=isAutoRefresh) BOOL autoRefresh;   // 是否自动刷新

// 样式
@property (nonatomic, strong) UIFont *refreshingHeaderStateLabelFont;       // 下拉刷新文字字体
@property (nonatomic, strong) UIColor *refreshingHeaderStateLabelTextColor; // 下拉刷新文字字体
@property (nonatomic, copy) NSString *refreshingHeaderTitleIdleText;        // 下拉刷新静态文字
@property (nonatomic, copy) NSString *refreshingHeaderTitlePullingText;     // 下拉时的文字
@property (nonatomic, copy) NSString *refreshingHeaderTitleRefreshingText;  // 正在刷新时显示的文字

@property (nonatomic, strong) UIFont *refreshingFooterStateLabelFont;       // 加载更多文字字体
@property (nonatomic, strong) UIColor *refreshingFooterStateLabelTextColor; // 加载更多文字颜色
@property (nonatomic, copy) NSString *refreshingFooterTitleIdleText;        // 加载更多静态文字
@property (nonatomic, copy) NSString *refreshingFooterTitleRefreshingText;  // 加载更多刷新时的文字
@property (nonatomic, copy) NSString *refreshingFooterTitleNoMoreDataText;  // 加载更多没有数据时的字体

#pragma mark - Method
- (instancetype)initWithDefaultValue;

@end
