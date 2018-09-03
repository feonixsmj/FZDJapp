//
//  FZDJMessageCenterModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterModel.h"

#import "FZDJMainRequest.h"
#import "FZDJMessageListVo.h"
#import "NSDate+FXExtention.h"

@interface FZDJMessageCenterModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJMessageCenterModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)readAllSuccess:(void (^)(void))success
               failure:(void (^)(NSError *))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiMsgReadALL];
    
    NSMutableDictionary *parameterDict = [NSMutableDictionary dictionary];
    parameterDict[@"userNo"] = dm.userInfo.userNo;
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)setMsgRead:(FZDJMessageCenterItem *)item
           success:(void (^)(FZDJMessageCenterItem *))success
           failure:(void (^)(NSError *))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiMsgRead];
    NSMutableDictionary *parameterDict = [NSMutableDictionary dictionary];
    parameterDict[@"msgNo"] = item.msgNo;
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        success(item);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSMutableDictionary *muParamDict = [NSMutableDictionary dictionary];
    muParamDict[@"queryPage"] = @(self.pageNumber);
    muParamDict[@"querySize"] = @(self.pageSize);
    muParamDict[@"userNo"] = dm.userInfo.userNo;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiMsgQuery];
    
    [self.request requestPostURL:url parameters:muParamDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJMessageListVo *listVo = [FZDJMessageListVo mj_objectWithKeyValues:responseObject];
            [self wrapperItems:listVo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
    
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)wrapperItems:(NSArray *)infoArray{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    for (FZDJMessageInfoVo *vo in infoArray) {
        FZDJMessageCenterItem *item = [[FZDJMessageCenterItem alloc] init];
        item.title = vo.title;
        item.subTitle = vo.content;
        item.time = [NSDate stringFormatterWithTimeInterval:vo.createTime];
        item.isRead = [vo.readStatus isEqualToString:@"Y"];
        item.msgNo = vo.msgNo;
        [muArr addObject:item];
    }
    self.items = muArr;
}
@end
