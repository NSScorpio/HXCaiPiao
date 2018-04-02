//
//  HXTableView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXTableView.h"
#import <MJRefresh/MJRefresh.h>

static NSString *const kHXTableViewCellReuseIdentifier = @"HXTableViewCellReuseIdentifier";

@interface HXTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HXTableView

- (instancetype)init {
    if (self = [super init]) {
        [self buildTableView];
    }
    return self;
}
- (instancetype)initWithViewModel:(HXTableViewModel *)viewModel {
    if (self = [super init]) {
        [self buildTableView];
        [self updateWithViewModel:viewModel];
    }
    return self;
}
- (void)buildTableView {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}
- (void)dealloc {
    [self removeKVO];
}

#pragma mark - KVO
- (void)addKVO {
    [self.viewModel addObserver:self forKeyPath:@"requestStatus" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)removeKVO {
    [self.viewModel removeObserver:self forKeyPath:@"requestStatus"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"requestStatus"]) {
        switch (self.viewModel.requestStatus) {
            case HXTableViewRequestStatusRefreshSuccess:
            case HXTableViewRequestStatusRefreshFailed:
                [self endRefreshRefreshing];
                break;
            case HXTableViewRequestStatusLoadMoreSuccess:
            case HXTableViewRequestStatusLoadMoreFailed:
                [self endRefreshRefreshing];
                break;
        }
    }
}

#pragma mark - Public
- (void)updateWithViewModel:(HXTableViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self addKVO];
    
    [self judgeIfNeedRefresh];
    
    if (self.viewModel.isAutoRefresh) {
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark - Private
- (void)reloadData {
    [self.tableView reloadData];
}
- (void)refreshDataSource {
    self.viewModel.refreshingStatus = HXTableViewRefreshingStatusRefresh;
}
- (void)loadMoreData {
    self.viewModel.refreshingStatus = HXTableViewRefreshingStatusLoadMore;
}
- (void)judgeIfNeedRefresh {
    if (self.viewModel.isCloseRefresh) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    } else {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataSource)];
        header.stateLabel.font = self.viewModel.refreshingHeaderStateLabelFont;
        header.stateLabel.textColor = self.viewModel.refreshingHeaderStateLabelTextColor;
        [header setTitle:self.viewModel.refreshingHeaderTitleIdleText forState:MJRefreshStateIdle];
        [header setTitle:self.viewModel.refreshingHeaderTitlePullingText forState:MJRefreshStatePulling];
        [header setTitle:self.viewModel.refreshingHeaderTitleRefreshingText forState:MJRefreshStateRefreshing];
        self.tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        footer.stateLabel.font = self.viewModel.refreshingFooterStateLabelFont;
        footer.stateLabel.textColor = self.viewModel.refreshingFooterStateLabelTextColor;
        [footer setTitle:self.viewModel.refreshingFooterTitleIdleText forState:MJRefreshStateIdle];
        [footer setTitle:self.viewModel.refreshingFooterTitleRefreshingText forState:MJRefreshStateRefreshing];
        [footer setTitle:self.viewModel.refreshingFooterTitleNoMoreDataText forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = footer;
    }
}
- (void)endRefreshRefreshing {
    [self reloadData];
    if (!self.viewModel.isCloseRefresh) {
        [self.tableView.mj_header endRefreshing];
    }
}
- (void)endLoadMoreRefreshing {
    [self reloadData];
    if (!self.viewModel.isCloseRefresh) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Delegate
#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.viewModel.cellHeightIndexPath = indexPath;
    return self.viewModel.cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.viewModel.cellReuseIdentifier = kHXTableViewCellReuseIdentifier;
    self.viewModel.tableView = tableView;
    self.viewModel.cellIndexPath = indexPath;
    return self.viewModel.cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.viewModel.selectIndexPath = indexPath;
}

#pragma mark - Setter

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
- (HXTableViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HXTableViewModel alloc] initWithDefaultValue];
    }
    return _viewModel;
}


@end
