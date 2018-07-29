//
//  FZDJMessageCenterModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterModel.h"
#import "FZDJMessageCenterItem.h"

@implementation FZDJMessageCenterModel

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    
    [self wrapperItems:nil];
    success(nil);
}

- (void)wrapperItems:(NSDictionary *)responseDict{
    
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger i=0; i < 20; i++) {
        FZDJMessageCenterItem *item = [[FZDJMessageCenterItem alloc] init];
        
        [muArr addObject:item];
    }
    self.items = muArr;
}
@end
