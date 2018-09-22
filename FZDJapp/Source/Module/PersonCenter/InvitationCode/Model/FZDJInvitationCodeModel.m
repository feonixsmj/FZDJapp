//
//  FZDJInvitationCodeModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/18.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJInvitationCodeModel.h"
#import "FZDJMainRequest.h"
#import "FZDJInvitationCodeVo.h"
#import "NSDate+FXExtention.h"

@interface FZDJInvitationCodeModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJInvitationCodeModel

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
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"queryPage"] = @(self.pageNumber) ;
    parameter[@"querySize"] = @(self.pageSize);
    parameter[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiqueryMyShare];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            FZDJInvitationCodeVo *vo = [FZDJInvitationCodeVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItems:vo.body];

            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

- (void)wrapperItems:(NSArray *)list{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    for (FZDJInvitationCodeInfoVo *vo in list) {
        FZDJInvitationCodeItem *item = [[FZDJInvitationCodeItem alloc] init];
        item.time = [NSDate stringFormatterWithTimeInterval:vo.createTime];;
        item.iconUrl = vo.headImg;
        item.name = vo.nickName;
        [muArr addObject:item];
    }
    
    self.items = muArr;
}
@end
