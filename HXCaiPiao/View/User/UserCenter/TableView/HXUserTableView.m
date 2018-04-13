//
//  HXUserTableView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXUserTableView.h"
#import "HXUserTableViewCell.h"

NSString *const HXTableViewIdleDataSourceDictionaryTitleKey = @"HXTableViewIdleDataSourceDictionaryTitleKey";
NSString *const HXTableViewIdleDataSourceDictionaryOptionTitlesKey = @"HXTableViewIdleDataSourceDictionaryOptionTitlesKey";
NSString *const HXTableViewIdleDataSourceDictionaryOptionImagesKey = @"HXTableViewIdleDataSourceDictionaryOptionImagesKey";
NSString *const HXTableViewIdleDataSourceDictionaryOptionIsShowKey = @"HXTableViewIdleDataSourceDictionaryOptionIsShowKey";

@interface HXUserTableView () <HXUserTableViewCellDelegate>

@property (nonatomic, strong) NSIndexPath *optionIndexPath; // section: cell所在行, row: option位置
@property (nonatomic, assign) HXUserTableViewEventType type;

@property (nonatomic, strong) NSMutableSet *showIndexPaths;

@end

@implementation HXUserTableView

- (instancetype)init {
    if (self = [super init]) {
        [self updateWithViewModel:[self buildViewModel]];
    }
    return self;
}

#pragma mark - KVO

#pragma mark - Public
- (void)configCell {
    HXUserTableViewCell *cell = [self.viewModel.tableView dequeueReusableCellWithIdentifier:self.viewModel.cellReuseIdentifier];
    if (!cell) {
        cell = [[HXUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.viewModel.cellReuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = Color_BG;
        cell.delegate = self;
    }
    
    NSDictionary *dataSource = self.viewModel.dataSourceArray[self.viewModel.cellIndexPath.row];
    NSString *title = dataSource[HXTableViewIdleDataSourceDictionaryTitleKey];
    [cell updateHeaderTitleWithTitle:title];
    
    NSNumber *isShow = dataSource[HXTableViewIdleDataSourceDictionaryOptionIsShowKey];
    if (isShow.boolValue) {
        [self.showIndexPaths addObject:self.viewModel.cellIndexPath];
    } else {
        [self.showIndexPaths removeObject:self.viewModel.cellIndexPath];
    }
    
    NSArray *titlesArr = dataSource[HXTableViewIdleDataSourceDictionaryOptionTitlesKey];
    NSArray *imagesArr = dataSource[HXTableViewIdleDataSourceDictionaryOptionImagesKey];
    [cell updateOptionsWithTitles:titlesArr images:imagesArr];
    
    self.viewModel.cell = cell;
}
- (void)configCellHeight {
    // 0.26   0.1 0.16    
//    self.viewModel.cellHeight =  0.26 * kScreen_Width + kCommon_Margin;
    self.viewModel.cellHeight = [self.showIndexPaths containsObject:self.viewModel.cellHeightIndexPath] ? 0.26 * kScreen_Width + kCommon_Margin : 0.1 * kScreen_Width;
}

#pragma mark - Public
- (void)eventHandler:(void (^)(HXUserTableViewEventType, NSIndexPath *))handler {
    if (handler) {
        switch (self.type) {
            case HXUserTableViewEventTypeFlex:
                if (self.viewModel.cellDelegateEventIndexPath) handler(self.type, self.viewModel.cellDelegateEventIndexPath);
                break;
            case HXUserTableViewEventTypeOption:
                if (self.optionIndexPath) handler(self.type, self.optionIndexPath);
                break;
        }
    }
}
- (void)cellShowOptionsViewAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return;
    }
    
    [self.viewModel.tableView beginUpdates];
    HXUserTableViewCell *cell = [self.viewModel.tableView cellForRowAtIndexPath:indexPath];
    [cell showOptionsView];
    [self.showIndexPaths addObject:indexPath];
    [self.viewModel.tableView endUpdates];
}
- (void)cellHideOptionsViewAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return;
    }
    [self.viewModel.tableView beginUpdates];
    HXUserTableViewCell *cell = [self.viewModel.tableView cellForRowAtIndexPath:indexPath];
    [cell hideOptionsView];
    [self.showIndexPaths removeObject:indexPath];
    [self.viewModel.tableView endUpdates];
}

#pragma mark - Private
- (HXTableViewModel *)buildViewModel {
    HXTableViewModel *viewModel = [[HXTableViewModel alloc] init];
    
    viewModel.closeRefresh = YES;
    viewModel.autoRefresh = NO;
    
    return viewModel;
}

#pragma mark - Delegate
#pragma mark HXUserTableViewCellDelegate
- (void)cellDidSelectHeader:(HXUserTableViewCell *)cell {
    NSIndexPath *cellIndexPath = [self.viewModel.tableView indexPathForCell:cell];
    self.type = HXUserTableViewEventTypeFlex;
    self.viewModel.cellDelegateEventIndexPath = cellIndexPath;
}
- (void)cell:(HXUserTableViewCell *)cell didSelectOptionAtIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.viewModel.tableView indexPathForCell:cell];
    self.optionIndexPath = [NSIndexPath indexPathForRow:index inSection:cellIndexPath.row];
    self.type = HXUserTableViewEventTypeOption;
    self.viewModel.cellDelegateEventIndexPath = cellIndexPath;
}

#pragma mark - Setter

#pragma mark - Getter
- (NSMutableSet *)showIndexPaths {
    if (!_showIndexPaths) {
        _showIndexPaths = [[NSMutableSet alloc] init];
    }
    return _showIndexPaths;
}

@end
