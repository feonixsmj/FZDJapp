//
//  UITabBar+FXBadge.h
//  FZDJapp
//
//  Created by smj on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITabBar (FXBadge)

- (void)showBageOnItemIndex:(NSInteger)index
                     number:(NSInteger)count;

- (void)hideBageOnItemIndex:(NSInteger)index;
@end


