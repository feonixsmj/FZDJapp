//
//  FZDJEditInfoModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJEditInfoModel.h"

@implementation FZDJEditInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phoneNumber = @"12313123";
        self.avatarImageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1530636122&di=b4c0d3c5fd3da960dc47595e4e0fbe49&src=http://s8.sinaimg.cn/middle/8b4624d4gab51c8fb9d97&690";
        self.nickName = @"小鸡";
        self.isBoy = NO;
    }
    return self;
}

- (void)reloadData{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    self.phoneNumber = @"12313123";
    self.avatarImageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1530636122&di=b4c0d3c5fd3da960dc47595e4e0fbe49&src=http://s8.sinaimg.cn/middle/8b4624d4gab51c8fb9d97&690";
    self.nickName = dm.userInfo.nickName;
    self.isBoy = dm.userInfo.sexInteger == 1 ? YES : NO;
}
@end
