//
//  FZDJBaseRequest.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJBaseRequest : NSObject

@property (nonatomic, assign) BOOL needEncrypt;

- (NSDictionary *)emptyParamterDict;

- (void) postWithURL:(NSString *)URL
                       parameters:(NSDictionary *)parameter
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
@end
