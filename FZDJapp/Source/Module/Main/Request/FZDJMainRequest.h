//
//  FZDJMainRequest.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
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
@property (nonatomic, assign) BOOL enableShowErrorMsg;

- (void)requestPostURL:(NSString *)url
            parameters:(NSDictionary *)parameterDict
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;
@end
