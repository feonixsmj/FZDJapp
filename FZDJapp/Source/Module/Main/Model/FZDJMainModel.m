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
    
    self.request.needEncrypt = YES;
    self.request.enableShowErrorMsg = NO;
    
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
    
    self.request.needEncrypt = YES;
    self.request.enableShowErrorMsg = YES;
    
    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskQuery];
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSDictionary *dict = @{
                           @"queryPage":@(self.pageNumber),
                           @"querySize":@(self.pageSize),
                           @"userNo":dm.userInfo.userNo,
                           @"deviceType":@"IOS"
                           };
    
    [self.request requestPostURL:url parameters:dict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJTasklistVo *vo = [FZDJTasklistVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItems:vo];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weak_self plusPageNumber];
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
        item.price = [NSString formatPrice:vo.taskReward];
        item.count = [NSString stringWithFormat:@"%ld/%ld",vo.taskGetCount,vo.taskTotalCount];
        item.persent = vo.taskGetCount / (vo.taskTotalCount*1.0) *100;
        
        [muArr addObject:item];
    }
    
    if (self.pageNumber > 1) {
        [self.items addObjectsFromArray:muArr];
    } else {
        self.items = muArr;
    }
    
}

- (void)checkUser:(NSDictionary *)parameterDict
          success:(void (^)(NSDictionary *))success
          failure:(void (^)(NSError *))failure{
    self.request.needEncrypt = YES;
    self.request.enableShowErrorMsg = NO;
    
//    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiCheckUser];
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSDictionary *dict = @{@"userNo":dm.userInfo.userNo};
    
    [self.request requestPostURL:url parameters:dict success:^(id responseObject) {
        
        success(nil);
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

- (void)loadConfigData{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiConfig];
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];

    self.request.needEncrypt = NO;
    self.request.enableShowErrorMsg = NO;
    [self.request requestPostURL:url parameters:@{} success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSString *body = dict[@"body"];
        if (![body isKindOfClass:[NSNull class]] && [body isEqualToString:@"Y"]) {
            dm.userInfo.isInReview = YES;
        } else {
            dm.userInfo.isInReview = NO;
        }
        
        [dm saveData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD wb_hideHUD];
    }];

}
@end
