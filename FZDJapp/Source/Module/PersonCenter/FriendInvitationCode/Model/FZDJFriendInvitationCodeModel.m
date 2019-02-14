//
//  FZDJFriendInvitationCodeModel.m
//  FZDJapp
//
//  Created by suminjie on 2018/11/20.
//  Copyright © 2018 FZDJ. All rights reserved.
//

#import "FZDJFriendInvitationCodeModel.h"
#import "FZDJMainRequest.h"

@interface FZDJFriendInvitationCodeModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJFriendInvitationCodeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
   
//    __weak typeof(self) weak_self = self;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameterDict];
    parameter[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiEditShareCode];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
