//
//  FZDJBankListModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankListModel.h"
#import "FZDJMainRequest.h"
#import "FZDJBankListVo.h"

@interface FZDJBankListModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJBankListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
    
    __weak typeof(self) weak_self = self;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryMyBank];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJBankListVo *vo = [FZDJBankListVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItem:vo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)wrapperItem:(NSArray *)list{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    
    for (FZDJBankListInfoVO *vo in list) {
        FZDJBanklistItem *item = [FZDJBanklistItem new];
        item.iconUrl = vo.bankIcon;
        item.bankName = vo.bankName;
        item.bankNumber = vo.bankCardNumber;
        
        if ([vo.bankColor isEqualToString:@"HONG"]) {
            item.bgColorHexStr = @"E55F61";
        } else if ([vo.bankColor isEqualToString:@"LAN"]){
            item.bgColorHexStr = @"3C67A5";
        } else if ([vo.bankColor isEqualToString:@"LV"]){
            item.bgColorHexStr = @"1B9F85";
        } else {//HUANG
            item.bgColorHexStr = @"FDC132";
        }
        
        item.vo = vo;
        [muArr addObject:item];
    }
    
    self.items = muArr;
}

- (void)deleteBankCardItem:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiDelUserBank];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            BOOL isSuccess;
            if (head && [head[@"respCode"] integerValue] == 0) {
                isSuccess = YES;
            } else {
                isSuccess = NO;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isSuccess) {
                    success(nil);
                } else {
                    failure(nil);
                }
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
