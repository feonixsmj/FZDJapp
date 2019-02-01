//
//  FXDJEditZhifubaoModel.m
//  FZDJapp
//
//  Created by smj on 2019/1/23.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJEditZhifubaoModel.h"
#import "FZDJMainRequest.h"

@interface FZDJEditZhifubaoModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJEditZhifubaoModel


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
    [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUpdateZFB];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        success(nil);
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
