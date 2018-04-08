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

@interface HXUserTableView () <HXUserTableViewCellDelegate>

@property (nonatomic, strong) NSIndexPath *optionIndexPath; // section: cell所在行, row: option位置
@property (nonatomic, assign) HXUserTableViewEventType type;

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
        cell.contentView.backgroundColor = self.viewModel.cellBackgroundColor;
        cell.delegate = self;
    }
    
    NSDictionary *dataSource = self.viewModel.dataSourceArray[self.viewModel.cellIndexPath.row];
    NSString *title = dataSource[HXTableViewIdleDataSourceDictionaryTitleKey];
    [cell updateHeaderTitleWithTitle:title];
    
    NSArray *titlesArr = dataSource[HXTableViewIdleDataSourceDictionaryOptionTitlesKey];
    NSArray *imagesArr = dataSource[HXTableViewIdleDataSourceDictionaryOptionImagesKey];
    [cell updateOptionsWithTitles:titlesArr images:imagesArr];
    
    self.viewModel.cell = cell;
}
- (void)configCellHeight {
    self.viewModel.cellHeight = 0.26 * kScreen_Width + kCommon_Margin;
    
    // 0.26   0.1 0.16
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

@end
