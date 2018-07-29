//
//  FZDJInvitationCodeModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/18.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJInvitationCodeModel.h"

@implementation FZDJInvitationCodeModel


- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems];
    success(nil);
}

- (void)wrapperItems{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger i = 0; i < 20; i++) {
        FZDJInvitationCodeItem *item = [[FZDJInvitationCodeItem alloc] init];
        item.time = @"2018-06-20 19:30:01";
        item.name = @"彩虹里的糖";
        
        [muArr addObject:item];
    }
    self.items = muArr;
}
@end
