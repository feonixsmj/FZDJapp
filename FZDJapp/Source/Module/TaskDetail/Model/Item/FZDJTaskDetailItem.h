//
//  FZDJTaskDetailItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FZDJTaskDetailItemStatus){
    FZDJTaskDetailItemStatusNormal = 1,//正常开始任务
    FZDJTaskDetailItemStatusTimeOut, //已结束
    FZDJTaskDetailItemStatusGetFinished, //已领完
    FZDJTaskDetailItemStatusTaken, //已领取
};

@interface FZDJTaskDetailItem : NSObject

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, strong) NSAttributedString *countAttributedStr;
@property (nonatomic, copy) NSString *beginTimeText;
@property (nonatomic, copy) NSString *endTimeText;
@property (nonatomic, assign) CGFloat persent;

@property (nonatomic, copy) NSString *taskUrl;
@property (nonatomic, copy) NSString *taskContent;

@property (nonatomic, assign) FZDJTaskDetailItemStatus status;

@end
