//
//  FZDJMyTaskModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyTaskModel.h"
#import "FXMyTaskViewController.h"
#import "FZDJMainRequest.h"
#import "FZDJMyTaskListVo.h"
#import "NSDate+FXExtention.h"

@interface FZDJMyTaskModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJMyTaskModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [FZDJMainRequest new];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskQueryMyTask];

    NSMutableDictionary *muPDict = [[NSMutableDictionary alloc] init];
    muPDict[@"queryPage"] = @(self.pageNumber);
    muPDict[@"querySize"] = @(self.pageSize);
    muPDict[@"taskInstStatus"] = self.pageIdentify;
    muPDict[@"userNo"] = dm.userInfo.userNo;
    
    [self.request requestPostURL:url parameters:muPDict success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJMyTaskListVo *taskListVo =
                [FZDJMyTaskListVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItems:taskListVo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)wrapperItems:(NSArray *)taskInfoArray {
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    
    for (FZDJMyTaskInfoVO *vo in taskInfoArray) {
        FZDJMyTaskItem *item = [[FZDJMyTaskItem alloc] init];
        item.iconURL = vo.taskImgUrl;
        item.title = vo.taskTitle;
        item.subTitle = vo.taskDesc;
        item.price = [NSString formatPrice:vo.taskReward];
        item.taskInstNo = vo.taskInstNo;
        
        if (self.pageIdentify == FXTaskCompleted) {
            item.time = @"";
            item.status = FXMyTaskItemStatusNone;
        } else{
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
        }
        [muArr addObject:item];
    }
    
    self.items = muArr;
}

@end
