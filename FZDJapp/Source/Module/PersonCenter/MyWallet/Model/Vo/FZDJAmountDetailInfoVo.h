//
//  FZDJAmountDetailInfoVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJAmountDetailInfoVo : NSObject
//afterValue (integer, optional): 变动后金额 ,
//beforeValue (integer, optional): 变动前金额 ,
//createTime (string, optional),
//createUser (integer, optional),
//flowNo (string, optional): 明细编码 ,
//id (integer, optional),
//operaDesc (string, optional): 明细说明(标题)：任务奖励、提现 ,
//operaType (string, optional): 明细类型：收入 JZ，支出 CZ,
//operaValue (integer, optional): 明细金额 ,
//status (string, optional),
//updateTime (string, optional),
//updateUser (integer, optional),
//userNo (string, optional): 会员编码

@property (nonatomic, copy) NSString *operaDesc;
@property (nonatomic, copy) NSString *operaType;
@property (nonatomic, assign) NSInteger operaValue;
@property (nonatomic, assign) NSTimeInterval createTime;
@end
