//
//  HXBaseView.m
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

#import "HXBaseView.h"

@implementation HXBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildForInit];
    }
    return self;
}
- (void)buildForInit {
    self.backgroundColor = Color_BG;
}

@end
