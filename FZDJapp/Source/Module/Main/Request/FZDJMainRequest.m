//
//  FZDJMainRequest.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainRequest.h"

@interface FZDJMainRequest ()

@end

@implementation FZDJMainRequest


- (void)requestPostURL:(NSString *)url
            parameters:(NSDictionary *)parameterDict
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    
    [self postWithURL:url parameters:parameterDict success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
