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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.enableShowErrorMsg = YES;
    }
    return self;
}

- (void)requestPostURL:(NSString *)url
            parameters:(NSDictionary *)parameterDict
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    
    __weak typeof(self) weak_self = self;
    [self postWithURL:url parameters:parameterDict success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        if (weak_self.enableShowErrorMsg) {
            [MBProgressHUD wb_showError:error.errorMsg];
        }
        
        failure(error);
    }];
    
}

@end
