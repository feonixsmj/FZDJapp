//
//  NSDictionary+FXCategory.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "NSDictionary+FXCategory.h"

@implementation NSDictionary (FXCategory)

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(NSDictionary *)dic{
    
    NSError *error = nil;
    NSString *jsonStr = [[NSString alloc] initWithData:
                         [NSJSONSerialization dataWithJSONObject:dic
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error]
                                              encoding:NSUTF8StringEncoding];
    
    if (!error) {
        return jsonStr;
    }
    
    return @"";
}
@end
