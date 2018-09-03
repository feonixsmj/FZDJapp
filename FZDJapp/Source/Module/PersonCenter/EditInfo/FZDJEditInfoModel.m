//
//  FZDJEditInfoModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJEditInfoModel.h"
#import "FZDJMainRequest.h"

@interface FZDJEditInfoModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJEditInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadData];
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)reloadData{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    self.phoneNumber = dm.userInfo.phoneNumber;
    self.avatarImageURL = dm.userInfo.avatarURL;
    self.nickName = dm.userInfo.nickName;
    self.isBoy = dm.userInfo.sexInteger == 1;
}


- (void)modifyPersonalInfo:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure{
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUserEditInfo];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:3];
    
    parameter[@"headImg"] = dm.userInfo.avatarURL;
    parameter[@"nickName"] = dm.userInfo.nickName;
    parameter[@"sex"] = dm.userInfo.sexInteger == 1 ?@"NAN":@"NV";
    parameter[@"userNo"] = dm.userInfo.userNo;
    
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSDictionary *head = dict[@"head"];
        if ([head[@"respCode"] integerValue] == 0 ) {
            success(nil);
        } else {
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
        NSLog(@"保存失败");
    }];
}
@end
