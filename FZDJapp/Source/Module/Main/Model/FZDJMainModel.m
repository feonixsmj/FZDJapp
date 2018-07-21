//
//  FZDJMainModel.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainModel.h"
#import "FZDJMainItem.h"
#import "FZDJMainRequest.h"
#import <PPNetworkHelper/PPNetworkHelper.h>

@interface FZDJMainModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJMainModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}
- (NSURLSessionTask *)loadItem2:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    
        NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    
    NSURLSessionTask * task = [PPNetworkHelper GET:@"http://api.budejie.com/api/api_open.php" parameters:para success:^(id responseObject) {
        
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        success(responseObject);
        
    } failure:^(NSError *error) {
        // 同上
        failure(error);
    }];
    
    return task;
}


- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure {
    

    __weak typeof(self) weak_self = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiBanner];
    
//    url = @"http://www.mobibounty.com/server/msg/count";
//    NSDictionary *dict = @{@"userNo":@"LZyzPPP7iEmEtYmu0SU62Gt9bEVO2qX8"};
//
//    url = @"http://www.mobibounty.com/server/task/query";
//    dict = @{@"channel":@"1",
//             @"operaId":@"2",
//             @"operaName":@"菜鸡",
//             @"queryPage":@(1),
//             @"querySize":@(1),
//             @"refreshCache":@"1",
//             @"userNo":@"LZyzPPP7iEmEtYmu0SU62Gt9bEVO2qX8",
//             };
    
    
    [self.request requestPostURL:url parameters:nil success:^(id responseObject) {
        [weak_self wrapperItems:nil];
        success(nil);
    } failure:^(NSError *error) {
        
    }];

//    [self wrapperItems:nil];
//    success(nil);
}



- (void)wrapperItems:(id )responseObject{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:20];
    
    for (NSInteger i=0; i < 40; i++) {
        FZDJMainItem *item = [[FZDJMainItem alloc] init];
        item.imageURL = @"";
        item.title = @"欢乐斗地主";
        item.subTitle = @"成功启动游戏，并试玩10分钟，即可获得奖励";
        item.timeText =@"剩余9小时";
        item.price = @"¥10.00";
        item.count = @"92/100";
        item.persent = 76;
        
        [muArr addObject:item];
    }
    self.items = muArr;
}
@end
