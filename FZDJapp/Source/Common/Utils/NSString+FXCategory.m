//
//  NSString+FXCategory.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "NSString+FXCategory.h"

@implementation NSString (FXCategory)

+ (NSString *)formatPrice:(NSInteger)cent{
    NSString *priceStr = [NSString stringWithFormat:@"¥%.2f",cent/100.00];
    return priceStr;
}
@end
