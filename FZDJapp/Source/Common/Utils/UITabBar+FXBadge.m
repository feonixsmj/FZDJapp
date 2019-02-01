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
        return;
    }else if (count <= 99) {
        badgeValue = [NSString stringWithFormat:@"%@",@(count)];
    }else {
        badgeValue = @"99+";
    }
    
    CGFloat sizeWidth = 20.f;
    
    //新建小红点
//    FXBadgeImageView *badgeView = [[FXBadgeImageView alloc] init];
    UIView *badgeView = [[UIView alloc] init];
//    badgeView.size = CGSizeMake(22, 18);
//    [badgeView setBackgroundImage:[UIImage imageNamed:@"icon_message_count"]];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.layer.cornerRadius = sizeWidth/2;
    
    CGRect tabFrame = self.frame;
    
    CGFloat percentX = (index + 0.55) / [self.items count];
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = 1;
    badgeView.frame = CGRectMake(x, y, sizeWidth, sizeWidth);//圆形大小为10'
    
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = badgeValue;
    
    if (count > 0 && count < 10) {
        label.font = [UIFont systemFontOfSize:12.0f];
    } else if (count > 10 && count < 99){
        label.font = [UIFont systemFontOfSize:10.0f];
    } else {
        label.font = [UIFont systemFontOfSize:9.0f];
    }
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(1, 1, sizeWidth-2, sizeWidth-2);
    
    [badgeView addSubview:label];
}

- (void)hideBageOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView fx_removeAllSubviews];
            [subView removeFromSuperview];
        }
    }
}

@end
