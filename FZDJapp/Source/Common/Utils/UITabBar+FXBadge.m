//
//  UITabBar+FXBadge.m
//  FZDJapp
//
//  Created by smj on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "UITabBar+FXBadge.h"
#import "FXBadgeImageView.h"
#define TabbarItemNums 4.0    //tabbar的数量

@implementation UITabBar (FXBadge)

- (void)showBageOnItemIndex:(NSInteger)index
                     number:(NSInteger)count{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    for (UIView * view in self.subviews) {
        if (view.tag >= 999) {
            return;
        }
    }
    
    if ([self.items count] == 0) {
        return;
    }
    
    NSString * badgeValue = @"";
    if (count == 0) {
        badgeValue = @"";
    }else if (count <= 99) {
        badgeValue = [NSString stringWithFormat:@"%@",@(count)];
    }else {
        badgeValue = @"99+";
    }
    //新建小红点
    FXBadgeImageView *badgeView = [[FXBadgeImageView alloc] init];
    badgeView.size = CGSizeMake(22, 18);
    [badgeView setBackgroundImage:[UIImage imageNamed:@"icon_message_count"]];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor clearColor];
    badgeView.badgeValue = badgeValue;
    CGRect tabFrame = self.frame;
    
    CGFloat percentX = (index + 0.55) / [self.items count];
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = 1;
    badgeView.frame = CGRectMake(x, y, 22.0, 18.0);//圆形大小为10'
    
    
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];

}

- (void)hideBageOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
