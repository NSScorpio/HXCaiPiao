//
//  HXTableViewDataStore.m
//  HXCaiPiao
//
//  Created by NSScorpio on 03/04/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXTableViewDataStore.h"

@interface HXTableViewDataStore ()

@property (nonatomic, strong) HXTableViewModel *viewModel;

@end

@implementation HXTableViewDataStore

- (instancetype)initWithViewModel:(HXTableViewModel *)viewModel {
    if (self = [super init]) {
        [self updateWithViewModel:viewModel];
    }
    return self;
}
- (void)updateWithViewModel:(HXTableViewModel *)viewModel {
    self.viewModel = viewModel;
    
#warning TODO Store
}

#pragma mark - KVO

#pragma mark - Public

#pragma mark - Private

#pragma mark - Delegate

#pragma mark - Setter

#pragma mark - Getter

@end
