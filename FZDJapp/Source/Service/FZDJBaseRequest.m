//
//  FZDJBaseRequest.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJBaseRequest.h"
#import "NSData+AES128.h"
#import "FSAES128.h"
#import "NSDictionary+FXCategory.h"
#import "FXSystemInfo.h"
#import "FXHTTPRequest.h"

@implementation FZDJBaseRequest

- (NSDictionary *)emptyParamterDict{
    NSDictionary *dict = @{};
    
    NSDictionary *defaultDict = @{@"status":@"E"};
    NSString *jsonstr = [NSDictionary jsonToString:defaultDict];
    NSString *encryptStr = [FSAES128 AES128Encrypt:jsonstr];

//    NSString *openUDID = [FXSystemInfo orginalIdfa];
    dict = @{@"secretData" : @{
                                @"appID" : @"poFYleKURAY7Z1t6npoluob7KQnFcmy2",
                                @"data" : encryptStr?encryptStr : @""
                              }
             };
    return dict;
}

- (NSDictionary *)encryptParamterDict:(NSDictionary *)parameterDict{
    NSDictionary *dict = @{};
    
    NSString *jsonstr = [NSDictionary jsonToString:parameterDict];
    NSString *encryptStr = [FSAES128 AES128Encrypt:jsonstr];
    
    //    NSString *openUDID = [FXSystemInfo orginalIdfa];
    dict = @{@"secretData" : @{
                     @"appID" : @"poFYleKURAY7Z1t6npoluob7KQnFcmy2",
                     @"data" : encryptStr?encryptStr : @""
                     }
             };
    return dict;
}

- (void)postWithURL:(NSString *)URL
                       parameters:(NSDictionary *)parameter
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    if (!parameter) {
        parameter = [self emptyParamterDict];
    } else {
        parameter = [self encryptParamterDict:parameter];
    }
    __weak typeof(self) weak_self = self;
    [FXHTTPRequest postWithURL:URL parameters:parameter success:^(id responseObject) {
        [weak_self decryptResponseToDictionary:responseObject];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSDictionary *)decryptResponseToDictionary:(id)responseObject{
    NSDictionary *dict = (NSDictionary *)responseObject;
    NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSString *encryptStr = dict[@"body"];
    encryptStr = [encryptStr stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    encryptStr = [encryptStr stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSString *decryptStr = [FSAES128 AES128Decrypt:encryptStr];
    
    NSData *data = [decryptStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *bodyDict = @{};
    if (data) {
       bodyDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    [muDict setValue:bodyDict forKey:@"body"];
    return muDict;
}


@end
