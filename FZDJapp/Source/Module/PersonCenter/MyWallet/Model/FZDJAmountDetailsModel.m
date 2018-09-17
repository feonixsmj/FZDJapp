//
//  FZDJAmountDetailsModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/11.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAmountDetailsModel.h"
#import "FZDJMainRequest.h"
#import "FZDJAmountDetailVo.h"
#import "NSDate+FXExtention.h"

@interface FZDJAmountDetailsModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJAmountDetailsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryWalletDetail];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userNo"] = dm.userInfo.userNo;
    parameter[@"queryPage"] = @(self.pageNumber);
    parameter[@"querySize"] = @(self.pageSize);
    
    __weak typeof(self) weak_self = self;
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJAmountDetailVo *vo = [FZDJAmountDetailVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItems:vo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)wrapperItems:(NSArray <FZDJAmountDetailInfoVo *> *)list{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    
    for (FZDJAmountDetailInfoVo *vo in list) {
        
        FZDJAmountDetailsItem *item = [FZDJAmountDetailsItem new];
        if ([vo.operaType isEqualToString: @"JZ"]) {
            item.isIncrease = YES;
            item.price =[NSString stringWithFormat:@"+%.2f",vo.operaValue/100.0f];
        } else{
            item.price =[NSString stringWithFormat:@"-%.2f",vo.operaValue/100.0f];
        }
        item.title = vo.operaDesc;
        item.time = [NSDate stringFormatterWithTimeInterval:vo.createTime];
        [muArr addObject:item];
    }
    self.items = muArr;
}
@end
