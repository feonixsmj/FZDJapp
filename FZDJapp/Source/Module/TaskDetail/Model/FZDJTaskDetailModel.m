//
//  FZDJTaskDetailModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJTaskDetailModel.h"
#import "FZDJMainRequest.h"
#import "NSDate+FXExtention.h"
#import "FXSystemInfo.h"

@interface FZDJTaskDetailModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end


@implementation FZDJTaskDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)getTask:(NSDictionary *)parameterDict
        success:(void (^)(NSDictionary *))success
        failure:(void (^)(NSError *))failure{
    
    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskTakeTask];
    
    NSMutableDictionary *paraDict = [[NSMutableDictionary alloc] init];
    NSString *openUDID = [FXSystemInfo orginalIdfa];
    paraDict[@"taskNo"] = self.taskInfo.taskNo;
    paraDict[@"userNo"] = @"LZyzPPP7iEmEtYmu0SU62Gt9bEVO2qX8";
    paraDict[@"deviceId"] = openUDID;
    paraDict[@"deviceType"] = @"IOS";
    
    [self.request requestPostURL:url parameters:paraDict success:^(id responseObject) {
        weak_self.item.taskUrl = responseObject[@"body"];
        success(nil);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    
    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskInfo];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJTaskInfoVo *taskInfo = [FZDJTaskInfoVo mj_objectWithKeyValues:responseObject[@"body"]];
            _taskInfo = taskInfo;
            [weak_self wrapperItems:taskInfo];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)wrapperItems:(FZDJTaskInfoVo *)vo{
    FZDJTaskDetailItem *item = [FZDJTaskDetailItem new];
    item.taskUrl = vo.taskUrl;
    item.taskContent = vo.taskContent;
    item.imageURL = vo.taskImgUrl;
    item.title = vo.taskTitle;
    
    item.beginTimeText = [NSString stringWithFormat:@"发布:%@",
                          [NSDate stringFormatterWithTimeInterval:vo.taskBeginTime]];
    
    item.endTimeText = [NSString stringWithFormat:@"截止:%@",
                          [NSDate stringFormatterWithTimeInterval:vo.taskEndTime]];
    
    item.price = [NSString formatPrice:vo.taskTotalPrice];
    item.persent = vo.taskGetCount / (vo.taskTotalCount*1.0) *100;
    
    NSString *countStr = [NSString stringWithFormat:@"%ld/%ld",vo.taskGetCount,vo.taskTotalCount];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:countStr];
    
    NSRange range = [countStr rangeOfString:@"/"];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor fx_colorWithHexString:@"#666666"]
                range:NSMakeRange(0, countStr.length - 1)];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor fx_colorWithHexString:@"#0B9DFF"]
                range:NSMakeRange(0, range.location)];
    
    item.countAttributedStr = str;
    
    NSDate *endTimeDate = [NSDate formatDate:vo.taskEndTime];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [endTimeDate timeIntervalSinceDate:nowDate];
    
    if (timeInterval < 0) {
        item.status = FZDJTaskDetailItemStatusTimeOut;
    } else if (vo.taskTotalCount == vo.taskGetCount){
        item.status = FZDJTaskDetailItemStatusGetFinished;
    } else {
        item.status = FZDJTaskDetailItemStatusNormal;
    }
    
    self.item = item;
}

@end
