//
//  FXBaseModel.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/26.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseModel : NSObject

//completed:(void (^)(void))completed
//failure:(void (^)(NSError *error))failure;

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure;
@end
