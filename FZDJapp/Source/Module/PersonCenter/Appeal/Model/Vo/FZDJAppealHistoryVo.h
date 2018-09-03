//
//  FZDJAppealHistoryVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/4.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJAppealHistoryVo : NSObject

/**
 申诉内容
 */
@property (nonatomic, copy) NSString *complaintContent;
/**
 申诉审核回复内容
 */
@property (nonatomic, copy) NSString *complaintReplyContent;

/**
 任务申诉状态：申诉待审核DSH、申诉不通过SHBTG、申诉审核通过SHTG、申诉关闭GB
 */
@property (nonatomic, copy) NSString *complaintStatus;

@property (nonatomic, copy) NSString *status;
/**
 申诉编码
 */
@property (nonatomic, copy) NSString *complaintNo;

/**
 ID
 */
@property (nonatomic, assign) NSInteger complaintID;

/**
 会员编码
 */
@property (nonatomic, copy) NSString *userNo;

/**
 任务实例编码
 */
@property (nonatomic, copy) NSString *taskInstNo;
@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, assign) NSTimeInterval createUser;

/**
  申诉图片
 */
@property (nonatomic, copy) NSString *complaintImg1;
@property (nonatomic, copy) NSString *complaintImg2;
@property (nonatomic, copy) NSString *complaintImg3;
@property (nonatomic, copy) NSString *complaintImg4;
@property (nonatomic, copy) NSString *complaintImg5;
@property (nonatomic, copy) NSString *complaintImg6;
@property (nonatomic, copy) NSString *complaintImg7;
@property (nonatomic, copy) NSString *complaintImg8;
@end
