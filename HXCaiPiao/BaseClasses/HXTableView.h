//
//  HXTableView.h
//  HXCaiPiao
//
//  Created by NSScorpio on 02/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  tableview 基类

#import "HXBaseView.h"
#import "HXTableViewModel.h"

@interface HXTableView : HXBaseView

@property (nonatomic, strong) HXTableViewModel *viewModel;

- (instancetype)initWithViewModel:(HXTableViewModel *)viewModel;
- (void)updateWithViewModel:(HXTableViewModel *)viewModel;

@end
