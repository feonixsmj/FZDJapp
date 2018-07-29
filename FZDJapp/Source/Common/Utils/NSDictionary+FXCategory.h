//
//  NSDictionary+FXCategory.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FXCategory)

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(NSDictionary *)dic;
@end
