//
//  FZDJAmountDetailsModel.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/11.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAmountDetailsModel.h"

@implementation FZDJAmountDetailsModel


- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems];
    success(nil);
}

- (void)wrapperItems{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i =0; i <20 ; i++) {
        FZDJAmountDetailsItem *item = [FZDJAmountDetailsItem new];
        if (i %2==0) {
            item.isIncrease = YES;
            item.title = @"收入-奖金";
            item.price = @"+8888.88";
        } else{
            item.title = @"支持-提现";
            item.price = @"-5000.00";
        }
        item.time = @"2018-05-09 18:21";
        
        [muArr addObject:item];
    }
    
    self.items = muArr;
}
@end
