//
//  FZDJTabBarController.h
//  FZDJapp
//
//  Created by smj on 2019/1/4.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FZDJMainVCL;

@interface FZDJTabBarController : UITabBarController

- (FZDJMainVCL *)getMainViewController;

@end
