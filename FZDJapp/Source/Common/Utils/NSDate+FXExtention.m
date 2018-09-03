//
//  NSDate+FXExtention.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "NSDate+FXExtention.h"

@implementation NSDate (FXExtention)



- (NSString *)timeAgo{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self];
    
    int days=((int)timeInterval)/(3600*24);
    int hours=((int)timeInterval)%(3600*24)/3600;
    int minute=((int)timeInterval)%(3600*24)%60;
    
    NSString *dateContent;
    if(days>0){
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i天%i小时%i分钟",days,hours,minute];
    }
    else if(hours>0){
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i小时%i分钟",hours,minute];
    }
    else{
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i分钟",minute];
    }
    
    if (time<=0) {
        dateContent=@"";
    }
    return dateContent;
    
}

- (NSString *)remainderDaysAndHours {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:nowDate];
    
    int days=((int)timeInterval)/(3600*24);
    int hours=((int)timeInterval)%(3600*24)/3600;
    
    NSString *dateContent;
    if(days>0){
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i天",days];
    }
    else if(hours>0){
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i小时",hours];
    }
    
    
    if (time<=0) {
        dateContent=@"";
    }
    return dateContent;
    
}

+ (NSDate *)formatDate:(NSTimeInterval)timeInterval {
    //如果传入的是毫秒,转成秒后计算
    if (timeInterval > 10000000000) {
        timeInterval = timeInterval/1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return date;
}

//将UTCDate(世界标准时间)转化为当地时区的标准Date（钟表显示的时间）
//NSDate *date = [NSDate date];   2018-03-27 06:54:41 +0000
//转化后：2018-03-27 14:54:41 +0000
-(NSDate *)getLocalDateFromUTCDate:(NSDate *)UTCDate{
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: UTCDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: UTCDate];
    
}


+(NSString *)stringFormatterWithTimeInterval:(NSTimeInterval)timeInterval{
    if (timeInterval > 10000000000) {
        timeInterval = timeInterval/1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    date = [NSDate dateWithTimeInterval: seconds sinceDate:date];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
}
@end
