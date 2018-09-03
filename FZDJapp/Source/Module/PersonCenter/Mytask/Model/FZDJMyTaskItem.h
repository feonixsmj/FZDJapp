//
//  FXMyTaskItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 卡片状态

 - FXMyTaskItemStatusNone: 无
 - FXMyTaskItemStatusAppeal: 申述
 - FXMyTaskItemStatusAppealing: 申述中
 - FXMyTaskItemStatusReply: 已回复
 - FXMyTaskItemStatusClose: 已关闭
 */
typedef NS_ENUM(NSUInteger, FXMyTaskItemStatus) {
    FXMyTaskItemStatusNone = 0,
    FXMyTaskItemStatusAppeal,
    FXMyTaskItemStatusAppealing,
    FXMyTaskItemStatusReply,
    FXMyTaskItemStatusClose
};

@interface FZDJMyTaskItem : NSObject

@property (nonatomic, copy) NSString *iconURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *taskInstNo;

@property (nonatomic, assign) FXMyTaskItemStatus status;


@end
