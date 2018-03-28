//
//  HXBaseNavigationController.h
//  HXCaiPiao
//
//  Created by NSScorpio on 27/03/2018.
//  Copyright © 2018 NSScorpio. All rights reserved.
//

//  导航控制器

#import <UIKit/UIKit.h>

@interface HXBaseNavigationController : UINavigationController

/**
 导航栏是否透明
 */
@property (nonatomic, assign, getter=isTransparent) BOOL transparent;

@end
