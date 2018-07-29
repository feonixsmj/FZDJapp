//
//  FZDJBaseRequest.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
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
        NSDictionary *dict = [weak_self decryptResponseToDictionary:responseObject];
        if ([dict[@"fail"] boolValue]) {
            NSString *msg = dict[@"customErrorMsg"];
            NSString *respMsg = dict[@"respMsg"];
            NSString *errorMsg = [respMsg copy];
            
            if (msg.length > 0) {
                errorMsg = [msg copy];
            }
            NSURL *failURL = [NSURL URLWithString:URL];
            NSDictionary *userInfo =
                @{NSLocalizedFailureReasonErrorKey: dict[@"respCode"],
                        NSLocalizedDescriptionKey : errorMsg};
            NSInteger errorcode = [dict[@"respCode"] integerValue];
            
            NSError *error = [NSError errorWithDomain:failURL.host
                                                 code:errorcode
                                             userInfo:userInfo];
            failure(error);
        } else{
            success(dict);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSDictionary *)decryptResponseToDictionary:(id)responseObject{
    NSDictionary *dict = (NSDictionary *)responseObject;
    NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSDictionary *headDict = muDict[@"head"];
    if ([headDict[@"respCode"] integerValue] != 0) {
        //返回错误
        [muDict setValue:@{} forKey:@"body"];
        muDict[@"fail"] = @(YES);
        return muDict;
    }
    
    NSString *encryptStr = dict[@"body"];
    if (encryptStr.length > 0) {
        encryptStr = [encryptStr stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
        encryptStr = [encryptStr stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    } else {
        //返回错误
        [muDict setValue:@{} forKey:@"body"];
        muDict[@"fail"] = @(YES);
        muDict[@"customErrorMsg"] = @"返回加密字段NULL";
        return muDict;
    }

    NSString  *decryptStr = [FSAES128 AES128Decrypt:encryptStr];
    
    decryptStr = [decryptStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    decryptStr = [decryptStr stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    
    NSData *data = [decryptStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    [muDict setValue:body forKey:@"body"];
    if (!body) {
        muDict[@"body"] = decryptStr;
    }
    return muDict;
}


@end
