//
//  NSDate+FXExtention.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FXExtention)

- (NSString *)timeAgo;

/**
 @return 剩余 X天，X小时
 */
- (NSString *)remainderDaysAndHours;

+ (NSDate *)formatDate:(NSTimeInterval)timeInterval;

/**
 输出yyyy-mm-dd hh:mm  格式

 @param timeInterval 时间戳
 @return 输出yyyy-mm-dd hh:mm  格式
 */
+(NSString *)stringFormatterWithTimeInterval:(NSTimeInterval)timeInterval;

-(NSDate *)getLocalDateFromUTCDate:(NSDate *)UTCDate;
@end
