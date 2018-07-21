//
//  FZDJMyWalletModel.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/9.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyWalletModel.h"

@implementation FZDJMyWalletModel

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems];
    success(nil);
}

-(void)wrapperItems{

    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:3];
    FZDJPriceItem *priceItem = [[FZDJPriceItem alloc] init];
    FZDJCashItem *cashItem = [[FZDJCashItem alloc] init];
    FZDJDescItem *descItem = [[FZDJDescItem alloc] init];
    
    
    [muArr addObject:priceItem];
    [muArr addObject:cashItem];
    [muArr addObject:descItem];
    
    self.items = muArr;
}


@end
