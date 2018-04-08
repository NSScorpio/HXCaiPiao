//
//  HXTableViewDataStore.h
//  HXCaiPiao
//
//  Created by NSScorpio on 03/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  列表数据处理

#import <Foundation/Foundation.h>
#import "HXTableViewModel.h"

@interface HXTableViewDataStore : NSObject

- (instancetype)initWithViewModel:(HXTableViewModel *)viewModel;
- (void)updateWithViewModel:(HXTableViewModel *)viewModel;

@end
