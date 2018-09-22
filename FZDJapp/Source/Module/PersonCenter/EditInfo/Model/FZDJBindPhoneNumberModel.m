//
//  FZDJBindPhoneNumberModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/22.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBindPhoneNumberModel.h"
#import "FZDJMainRequest.h"

@interface FZDJBindPhoneNumberModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJBindPhoneNumberModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)getCodeNumber:(NSDictionary *)parameterDict
              success:(void (^)(NSDictionary *dict))success
              failure:(void (^)(NSError *error))failure{
    
    //    __weak typeof(self) weak_self = self;
    NSMutableDictionary *parameter =
    [NSMutableDictionary dictionaryWithDictionary:parameterDict];
    parameter[@"type"] = @"DL";
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskGetLoginCode];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        success(dict);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)bindPhoneNumber:(NSDictionary *)parameterDict
                success:(void (^)(NSDictionary *dict))success
                failure:(void (^)(NSError *error))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUpdatePhone];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *userNo = dict[@"body"][@"userNo"];

        success(nil);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
