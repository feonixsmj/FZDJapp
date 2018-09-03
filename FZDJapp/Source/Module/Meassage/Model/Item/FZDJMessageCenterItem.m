//
//  FZDJMessageCenterItem.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterItem.h"

@implementation FZDJMessageCenterItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"标题";
        self.subTitle = @"束带结发说的是地方是是反馈撒酒疯历史课就发水电费是速度快放假";
        self.time = @"2018-10-10 21:21";
        self.isRead = NO;
    }
    return self;
}
@end
