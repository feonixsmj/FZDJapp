//
//  FZDJApproveModel.m
//  FZDJapp
//
//  Created by smj on 2019/2/2.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJApproveModel.h"
#import "FZDJMainRequest.h"

@interface FZDJApproveModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJApproveModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}


- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    __weak typeof(self) weak_self = self;
    NSString *url =
    [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUserAuth];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        success(nil);
    } failure:^(NSError *error) {
//        success(nil);
        failure(error);
    }];
    
}

@end
