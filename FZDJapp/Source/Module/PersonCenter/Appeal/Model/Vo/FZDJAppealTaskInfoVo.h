//
//  FZDJAppealTaskInfoVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/31.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJAppealTaskInfoVo : NSObject
/**
 图片
 */
@property (nonatomic, copy) NSString *taskImgUrl;

/**
 任务内容
 */
@property (nonatomic, copy) NSString *taskContent;

/**
 任务编码
 */
@property (nonatomic, copy) NSString *taskNo;

/**
 任务单价奖励 单位：分
 */
@property (nonatomic, assign) NSInteger taskReward;

/**
 任务已领取数
 */
@property (nonatomic, assign) NSInteger taskGetCount;
/**
 任务标题
 */
@property (nonatomic, copy) NSString *taskTitle;
/**
 任务描述，subtitle
 */
@property (nonatomic, copy) NSString *taskDesc;
/**
 任务实例编码
 */
@property (nonatomic, copy) NSString *taskInstNo;
/**
 任务总可领取数量
 */
@property (nonatomic, assign) NSInteger taskTotalCount;
/**
 任务申诉状态：申诉待审核DSH、申诉不通过SHBTG、申诉审核通过SHTG、申诉关闭GB
 */
@property (nonatomic, copy) NSString *taskInstComplaintStatus;

@property (nonatomic, assign) NSTimeInterval taskBeginTime;
@property (nonatomic, assign) NSTimeInterval taskEndTime;
/**
 任务完成状态：已完成YWC、未完成WWC
 */
@property (nonatomic, copy) NSString *taskInstStatus;

@end
