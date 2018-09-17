//
//  FZDJMyWalletModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/9.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyWalletModel.h"
#import "FZDJMainRequest.h"
#import "FZDJMyWalletVO.h"

@interface FZDJMyWalletModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJMyWalletModel

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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiGetWallet];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userNo"] = dm.userInfo.userNo;
    __weak typeof(self) weak_self = self;
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJMyWalletVO *vo = [FZDJMyWalletVO mj_objectWithKeyValues:responseObject[@"body"]];
            [weak_self wrapperItems:vo];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });

    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)wrapperItems:(FZDJMyWalletVO *)vo{
    
    self.totalAmount = [NSString formatPriceNumber:vo.totalAmount];
    
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:3];
    FZDJPriceItem *priceItem = [[FZDJPriceItem alloc] init];
    priceItem.validAmountStr = [NSString formatPriceNumber:vo.validAmount];
    priceItem.useAmountStr = [NSString formatPriceNumber:vo.useAmount];
    
    FZDJCashItem *cashItem = [[FZDJCashItem alloc] init];
    FZDJDescItem *descItem = [[FZDJDescItem alloc] init];
    
    [muArr addObject:priceItem];
    [muArr addObject:cashItem];
    [muArr addObject:descItem];
    
    self.items = muArr;
}

- (void)loadCashAdvanceDesc:(NSDictionary *)parameterDict
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *))failure {

    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApitxsm];
    __weak typeof(self) weak_self = self;
    
    [self.request requestPostURL:url parameters:nil success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            BOOL isSuccess;
            if (head && [head[@"respCode"] integerValue] == 0) {
                isSuccess = YES;
            } else {
                isSuccess = NO;
            }
            weak_self.cashAdvanceDesc = dict[@"body"];
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
