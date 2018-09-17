//
//  NSString+FXCategory.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#import <Foundation/Foundation.h>

@interface NSString (FXCategory)

+ (NSString *)formatPrice:(NSInteger)cent;
+ (NSString *)formatPriceNumber:(NSNumber *)centNum;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end
