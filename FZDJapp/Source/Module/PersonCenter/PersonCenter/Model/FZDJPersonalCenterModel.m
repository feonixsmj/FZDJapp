//
//  FZDJPersonalCenterModel.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalCenterModel.h"

@implementation FZDJPersonalCenterModel


- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems];
    success(nil);
}

- (void)wrapperItems{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    FZDJPersonalInfoItem *infoItem = [FZDJPersonalInfoItem new];
    infoItem.avatarUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1530636122&di=b4c0d3c5fd3da960dc47595e4e0fbe49&src=http://s8.sinaimg.cn/middle/8b4624d4gab51c8fb9d97&690";
    infoItem.isGirl = YES;
    infoItem.nickName = @"鸡仔";
    [muArr addObject:infoItem];
    
    FZDJPersonalTaskItem *taskItem = [FZDJPersonalTaskItem new];
    [muArr addObject:taskItem];
    
    NSArray *listArr = [self getListItemArray];
    [muArr addObjectsFromArray:listArr];
    
    self.items = muArr;
}

- (NSArray *)getListItemArray{
    
    FZDJPersonalListItem *bankItem = [FZDJPersonalListItem new];
    bankItem.icImageName = @"dj_yhka_icon";
    bankItem.bgImageName = @"dj_card_top";
    bankItem.title = @"银行卡";
    bankItem.hiddenLine = NO;
    bankItem.actionType = FZDJCellActionTypeBankCard;
    
    FZDJPersonalListItem *weixinItem = [FZDJPersonalListItem new];
    weixinItem.icImageName = @"dj_weixin_icon";
    weixinItem.title = @"微信";
    weixinItem.descStr = @"鸡仔";
    weixinItem.hiddenArrow = YES;
    weixinItem.hiddenLine = NO;
    weixinItem.actionType = FZDJCellActionTypeWeixin;
    
    FZDJPersonalListItem *qqItem = [FZDJPersonalListItem new];
    qqItem.icImageName = @"dj_qq_icon";
    qqItem.title = @"QQ";
    qqItem.descStr = @"去绑定";
    qqItem.hiddenLine = NO;
    qqItem.actionType = FZDJCellActionTypeQQ;
    
    FZDJPersonalListItem *weiboItem = [FZDJPersonalListItem new];
    weiboItem.icImageName = @"dj_weibo_icon";
    weiboItem.bgImageName = @"dj_card_bottom";
    weiboItem.title = @"微博";
    weiboItem.descStr = @"去绑定";
    weiboItem.actionType = FZDJCellActionTypeWeibo;
    
    FZDJPersonalListItem *shareItem = [FZDJPersonalListItem new];
    shareItem.icImageName = @"dj_share_icon";
    shareItem.bgImageName = @"dj_card_top";
    shareItem.title = @"好友分享码";
    shareItem.descStr = @"21312121";
    shareItem.hiddenArrow = YES;
    shareItem.hiddenLine = NO;
    shareItem.actionType = FZDJCellActionTypeFriedShareCode;
    
    FZDJPersonalListItem *aboutUsItem = [FZDJPersonalListItem new];
    aboutUsItem.icImageName = @"dj_us_icon";
    aboutUsItem.title = @"关于我们";
    aboutUsItem.hiddenLine = NO;
    aboutUsItem.actionType = FZDJCellActionTypeAboutUs;
    
    FZDJPersonalListItem *serverItem = [FZDJPersonalListItem new];
    serverItem.icImageName = @"dj_kefu_icon";
    serverItem.bgImageName = @"dj_card_bottom";
    serverItem.title = @"联系客服";
    serverItem.hiddenArrow = YES;
    serverItem.descStr = @"123123213@qq.com";
    serverItem.actionType = FZDJCellActionTypeContactUs;
    
    FZDJPersonalBlankItem *blankItem = [FZDJPersonalBlankItem new];

    NSArray *listArr = @[bankItem,
                         weixinItem,
                         qqItem,
                         weiboItem,
                         blankItem,
                         shareItem,
                         aboutUsItem,
                         serverItem,
                         blankItem
                         ];
    
    return listArr;
}

@end
