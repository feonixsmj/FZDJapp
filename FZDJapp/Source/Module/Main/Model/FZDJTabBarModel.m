//
//  FZDJTabBarModel.m
//  FZDJapp
//
//  Created by smj on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJTabBarModel.h"
#import "FZDJMainRequest.h"

@interface FZDJTabBarModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJTabBarModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUnreadMessageCount];
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc] init];
    mudict[@"userNo"] = dm.userInfo.userNo;
    
    [self.request requestPostURL:url parameters:mudict success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSNumber *count = dict[@"body"];
        
        if (count && count.integerValue > 0) {
            dm.userInfo.messageCount = count.integerValue;
            success(@{@"count":count});
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
