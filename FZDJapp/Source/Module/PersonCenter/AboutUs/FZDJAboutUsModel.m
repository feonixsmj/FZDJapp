//
//  FZDJAboutUsModel.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/5.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJAboutUsModel.h"
#import "FZDJMainRequest.h"

@interface FZDJAboutUsModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJAboutUsModel

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
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiAboutUsDesc];
    
    [self.request requestPostURL:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSString *htmlStr = dict[@"body"];
        weak_self.htmlStr = htmlStr;
        success(nil);
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

@end
