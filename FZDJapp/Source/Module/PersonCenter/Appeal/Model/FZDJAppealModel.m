//
//  FZDJAppealModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealModel.h"
#import "FZDJMainRequest.h"
#import "FZDJAppealTaskInfoVo.h"
#import "NSDate+FXExtention.h"
#import "FZDJAppealHistoryListVo.h"

@interface FZDJAppealModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJAppealModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [FZDJMainRequest new];
    }
    return self;
}

- (void)loadAppealHistory:(NSDictionary *)parameterDict
                  success:(void (^)(NSDictionary *))success
                  failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    NSString *url =
        [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskQueryComplaint];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJAppealHistoryListVo *listVo = [FZDJAppealHistoryListVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperHistoryItems:listVo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    __weak typeof(self) weak_self = self;
    NSString *url =
        [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskGetTaskInst];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJAppealTaskInfoVo *taskInfoVo =
                [FZDJAppealTaskInfoVo mj_objectWithKeyValues:responseObject[@"body"]];
            [weak_self wrapperItem:taskInfoVo];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)wrapperItem:(FZDJAppealTaskInfoVo *)vo{
    
    FZDJMyTaskItem *item = [[FZDJMyTaskItem alloc] init];
    item.iconURL = vo.taskImgUrl;
    item.title = vo.taskTitle;
    item.subTitle = vo.taskDesc;
    item.price = [NSString formatPrice:vo.taskReward];
    item.taskInstNo = vo.taskInstNo;
    
    item.time = [[NSDate formatDate:vo.taskEndTime]
                 remainderDaysAndHours];
    
    if([vo.taskInstComplaintStatus isEqualToString:@"SHTG"]){
        //关闭
        item.status = FXMyTaskItemStatusClose;
    } else if ([vo.taskInstComplaintStatus isEqualToString:@"DSH"]){
        //申述中
        item.status = FXMyTaskItemStatusAppealing;
    } else if ([vo.taskInstComplaintStatus isEqualToString:@"SHBTG"]){
        //已回复
        item.status = FXMyTaskItemStatusReply;
    } else {
        item.status = FXMyTaskItemStatusAppeal;
    }
        
    self.item = item;
}


- (void)wrapperHistoryItems: (NSArray <FZDJAppealHistoryVo *>*)voArray{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    
    for (FZDJAppealHistoryVo *vo in voArray) {
        FZDJAppealHistoryItem *item = [FZDJAppealHistoryItem new];
        item.time = [NSDate stringFormatterWithTimeInterval:vo.createTime];
        item.contentStr = vo.complaintContent;
        item.replyStr = vo.complaintReplyContent;
        item.imageUrl1 = vo.complaintImg1;
        item.imageUrl2 = vo.complaintImg2;
        item.imageUrl3 = vo.complaintImg3;
        item.imageUrl4 = vo.complaintImg4;
        [muArr addObject:item];
    }
    self.historyItems = muArr;
}

#pragma mark - ================ 提交申诉 ================

- (void)submitAppeal:(NSDictionary *)parameterDict
             success:(void (^)(NSDictionary *dict))success
             failure:(void (^)(NSError *error))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSMutableDictionary *parameter = [NSMutableDictionary
                                      dictionaryWithDictionary:parameterDict];
    parameter[@"userNo"] = dm.userInfo.userNo;
    
    
    NSString *url =
        [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskComplaint];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"body"] isEqualToString:@"申诉成功"]) {
            success(nil);
        } else {
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
