//
//  FXHTTPRequest.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXHTTPRequest.h"
#import "FXInterfaceConst.h"
#import "PPNetworkHelper.h"

@implementation FXHTTPRequest

+ (NSURLSessionTask *)postWithURL:(NSString *)URL
                          parameters:(NSDictionary *)parameter
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    [PPNetworkHelper setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
//    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    
//    [PPNetworkHelper setValue:[NSString stringWithFormat:@"application/json;charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    
    // 发起请求
    
    return [PPNetworkHelper POST:URL parameters:parameter success:^(id responseObject) {
        
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        success(responseObject);
        
    } failure:^(NSError *error) {
        // 同上
        failure(error);
    }];
}

+ (NSURLSessionTask *)GETWithURL:(NSString *)URL
                      parameters:(NSDictionary *)parameter
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    return [PPNetworkHelper GET:URL parameters:parameter success:^(id responseObject) {
        
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        success(responseObject);
        
    } failure:^(NSError *error) {
        // 同上
        failure(error);
    }];
}
@end
