//
//  FZDJTaskDetailModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJTaskInfoVo.h"
#import "FZDJTaskDetailItem.h"

@interface FZDJTaskDetailModel : FXBaseModel

@property (nonatomic, strong, readonly) FZDJTaskInfoVo *taskInfo;
@property (nonatomic, strong) FZDJTaskDetailItem *item;


/**
 领取任务

 @param parameterDict 参数
 @param success 成功
 @param failure 失败
 */
- (void)getTask:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure;
@end
