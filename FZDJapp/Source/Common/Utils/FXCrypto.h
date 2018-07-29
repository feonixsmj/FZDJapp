//
//  FXCrypto.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXCrypto : NSObject

+ (NSString *)md5:(NSString *)string;

+ (NSString*)base64encode:(NSString*)input;

+ (NSString*)base64decode:(NSString *)str;

+ (NSString*)base64decodeMBString:(NSString *)str;
@end
