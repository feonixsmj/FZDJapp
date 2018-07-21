//
//  FXHTTPRequest.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXInterfaceConst.h"

@interface FXHTTPRequest : NSObject

+ (NSURLSessionTask *)postWithURL:(NSString *)URL
                          parameters:(NSDictionary *)parameter
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

+ (NSURLSessionTask *)GETWithURL:(NSString *)URL
                       parameters:(NSDictionary *)parameter
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
@end
