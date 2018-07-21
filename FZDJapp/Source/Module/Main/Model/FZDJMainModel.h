//
//  FZDJMainModel.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"

@interface FZDJMainModel : FXBaseModel

- (void)loadItem:(NSDictionary *)parameterDict
                        success:(void (^)(NSDictionary *))success
                        failure:(void (^)(NSError *))failure;
@end
