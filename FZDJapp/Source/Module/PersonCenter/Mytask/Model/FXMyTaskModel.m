//
//  FXMyTaskModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXMyTaskModel.h"
#import "FXMyTaskViewController.h"

@implementation FXMyTaskModel

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems];
    success(nil);
}

-(void)wrapperItems{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger i = 0; i < 20; i++) {
        FXMyTaskItem *item = [[FXMyTaskItem alloc] init];
        item.iconURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1530636122&di=b4c0d3c5fd3da960dc47595e4e0fbe49&src=http://s8.sinaimg.cn/middle/8b4624d4gab51c8fb9d97&690";
        item.title = @"欢乐斗地主";
        item.subTitle = @"成功启动游戏，并试玩10分钟，即可获得奖励";
        item.price = @"¥10.00";
        if (self.pageIdentify == FXTaskCompleted) {
            item.time = @"";
            item.status = FXMyTaskItemStatusNone;
        } else{
            item.time = @"剩余9小时";
            NSInteger num = (arc4random() % 4);
            item.status = num + 1;
        }
        [muArr addObject:item];
    }
    self.items = muArr;
}

@end
