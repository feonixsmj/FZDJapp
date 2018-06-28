//
//  FXHTTPRequest.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/26.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXHTTPRequest : NSObject


- (NSURLSessionTask *)requestWithURL:(NSString *)URL
                          parameters:(NSDictionary *)parameter
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;
@end
