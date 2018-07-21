//
//  FXBaseModel.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseModel : NSObject

//completed:(void (^)(void))completed
//failure:(void (^)(NSError *error))failure;


/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *items;

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure;
@end
