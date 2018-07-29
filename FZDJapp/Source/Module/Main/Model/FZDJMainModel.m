//
//  FZDJMainModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainModel.h"
#import "FZDJMainItem.h"
#import "FZDJMainRequest.h"
#import "FZDJTasklistVo.h"
#import <PPNetworkHelper/PPNetworkHelper.h>

@interface FZDJMainModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJMainModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadBannerInfo:(NSDictionary *)parameterDict
               success:(void (^)(NSDictionary *))success
               failure:(void (^)(NSError *))failure {
    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiBanner];
    
    [self.request requestPostURL:url parameters:nil success:^(id responseObject) {
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJBannerListVo *vo = [FZDJBannerListVo mj_objectWithKeyValues:responseObject];
            NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:3];
            for (FZDJBannerVo *bannerVo in vo.body) {
                [muArr addObject:bannerVo];
            }
            weak_self.bannerArr = muArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    

    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskQuery];
    
//    url = @"http://www.mobibounty.com/server/msg/count";
//    NSDictionary *dict = @{@"userNo":@"LZyzPPP7iEmEtYmu0SU62Gt9bEVO2qX8"};
//
//    url = @"http://www.mobibounty.com/server/task/query";
    NSDictionary *dict = @{
                           @"queryPage":@(1),
                           @"querySize":@(10),
                           @"userNo":@"LZyzPPP7iEmEtYmu0SU62Gt9bEVO2qX8",
                           };
    
    
    [self.request requestPostURL:url parameters:dict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJTasklistVo *vo = [FZDJTasklistVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItems:vo];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

- (void)wrapperItems:(FZDJTasklistVo *)taskListVo{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    
    for (FZDJTaskInfoVo *vo in taskListVo.body) {
        FZDJMainItem *item = [[FZDJMainItem alloc] init];
        item.taskId = vo.taskID;
        item.taskNo = vo.taskNo;
        item.imageURL = vo.taskImgUrl;
        item.title = vo.taskTitle;
        item.subTitle = vo.taskDesc;
        item.timeText = [[NSDate formatDate:vo.taskEndTime] remainderDaysAndHours];
        item.price = [NSString formatPrice:vo.taskTotalPrice];
        item.count = [NSString stringWithFormat:@"%ld/%ld",vo.taskGetCount,vo.taskTotalCount];
        item.persent = vo.taskGetCount / (vo.taskTotalCount*1.0) *100;
        
        [muArr addObject:item];
    }
    
    self.items = muArr;
}
@end
