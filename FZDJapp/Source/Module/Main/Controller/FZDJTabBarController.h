//
//  FZDJTabBarController.h
//  FZDJapp
//
//  Created by FZYG on 2019/1/4.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FZDJMainVCL;

@interface FZDJTabBarController : UITabBarController

- (FZDJMainVCL *)getMainViewController;

- (void)requestMessageCount;
@end

