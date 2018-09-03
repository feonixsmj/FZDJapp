//
//  FZDJTaskInfoVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBaseBVO.h"

@interface FZDJTaskInfoVo : FZDJBaseBVO

@property (nonatomic, assign) NSInteger taskID;
@property (nonatomic, assign) NSTimeInterval taskBeginTime;
@property (nonatomic, assign) NSTimeInterval taskEndTime;
/**
 任务标题
 */
@property (nonatomic, copy) NSString *taskTitle;

/**
 任务描述，subtitle
 */
@property (nonatomic, copy) NSString *taskDesc;
/**
 图片
 */
@property (nonatomic, copy) NSString *taskImgUrl;
/**
 任务内容
 */
@property (nonatomic, copy) NSString *taskContent;
/**
 任务跳转链接
 */
@property (nonatomic, copy) NSString *taskUrl;
/**
 任务已领取数
 */
@property (nonatomic, assign) NSInteger taskGetCount;
/**
 任务总可领取数量
 */
@property (nonatomic, assign) NSInteger taskTotalCount;

/**
 任务单价奖励 单位：分
 */
@property (nonatomic, assign) NSInteger taskReward;
/**
 任务总价 单位：分
 */
@property (nonatomic, assign) NSInteger taskTotalPrice;
/**
 任务编码
 */
@property (nonatomic, copy) NSString *taskNo;
/**
 任务审核状态：待审核(DSH)、审核通过(SHTG)
 */
@property (nonatomic, copy) NSString *taskStatus;

@property (nonatomic, copy) NSString *taskType;

@property (nonatomic, copy) NSString *conditions;

@end
