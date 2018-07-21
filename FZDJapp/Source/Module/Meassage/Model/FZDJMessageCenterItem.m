//
//  FZDJMessageCenterItem.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterItem.h"

@implementation FZDJMessageCenterItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1530636122&di=b4c0d3c5fd3da960dc47595e4e0fbe49&src=http://s8.sinaimg.cn/middle/8b4624d4gab51c8fb9d97&690";
        self.title = @"标题";
        self.subTitle = @"束带结发说的是地方是是反馈撒酒疯历史课就发水电费是速度快放假";
        self.time = @"2018-10-10 21:21";
        self.isRead = NO;
    }
    return self;
}
@end
