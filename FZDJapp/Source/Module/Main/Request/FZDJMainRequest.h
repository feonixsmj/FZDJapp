//
//  FZDJMainRequest.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBaseRequest.h"
#import "FXInterfaceConst.h"

@interface FZDJMainRequest : FZDJBaseRequest
//
//- (void)requestByPost:(NSDictionary *)parameterDict
//              success:(void (^)(id responseObject))success
//              failure:(void (^)(NSError *error))failure;

- (void)requestPostURL:(NSString *)url
            parameters:(NSDictionary *)parameterDict
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;
@end
