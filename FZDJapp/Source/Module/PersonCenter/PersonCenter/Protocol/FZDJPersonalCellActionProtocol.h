//
//  FZDJPersonalCellActionProtocol.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/7.
//  Copyright © 2018年 FZYG. All rights reserved.
//


/**
 个人中心Cell事件类型

 - FZDJCellActionTypeModifyAvatar: 修改头像
 - FZDJCellActionTypeModifyPersonalInfo: 修改个人自信息
 - FZDJCellActionTypeRealNameVerify: 实名认证
 - FZDJCellActionTypeWallet: 我的钱包
 - FZDJCellActionTypeTask: 我的任务
 - FZDJCellActionTypeInvitationCode: 邀请码
 - FZDJCellActionTypeBankCard: 银行卡
 - FZDJCellActionTypeWeixin: 微信
 - FZDJCellActionTypeQQ: QQ
 - FZDJCellActionTypeWeibo: 微博
 - FZDJCellActionTypeFriedShareCode: 好用分享码
 - FZDJCellActionTypeAboutUs: 关于我们
 - FZDJCellActionTypeContactUs: 联系我们
 */
typedef NS_ENUM(NSUInteger, FZDJCellActionType) {
    
    FZDJCellActionTypeModifyAvatar = 3001,
    FZDJCellActionTypeModifyPersonalInfo = 3002,
    FZDJCellActionTypeWallet = 3004,
    FZDJCellActionTypeTask = 3005,
    FZDJCellActionTypeInvitationCode = 3006,
    FZDJCellActionTypeBankCard = 3007,
    FZDJCellActionTypeWeixin = 3008,
    FZDJCellActionTypeQQ = 3009,
    FZDJCellActionTypeWeibo = 3010,
    FZDJCellActionTypeFriedShareCode = 3011,
    FZDJCellActionTypeAboutUs = 3012,
    FZDJCellActionTypeContactUs = 3013,
    FZDJCellActionTypeCheckUpdate = 3014,
    FZDJCellActionTypeZhifubao = 3015
};

@protocol FZDJPersonalCellActionProtocol<NSObject>

- (void)personalCellActionForwarder:(FZDJCellActionType)actionType;

@end
