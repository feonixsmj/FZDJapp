//
//  FZDJAppealModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJAppealTaskInfoItem.h"
#import "FZDJMyTaskItem.h"
#import "FZDJAppealHistoryItem.h"

@interface FZDJAppealModel : FXBaseModel

@property (nonatomic, strong) FZDJMyTaskItem *item;
@property (nonatomic, strong) NSArray <FZDJAppealHistoryItem *> *historyItems;

//获取申诉历史
- (void)loadAppealHistory:(NSDictionary *)parameterDict
                  success:(void (^)(NSDictionary *))success
                  failure:(void (^)(NSError *))failure;


//提交申诉
- (void)submitAppeal:(NSDictionary *)parameterDict
             success:(void (^)(NSDictionary *dict))success
             failure:(void (^)(NSError *error))failure;
@end
