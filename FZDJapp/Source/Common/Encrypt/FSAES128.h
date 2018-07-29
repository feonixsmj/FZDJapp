//
//  FSAES128.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/19.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSAES128 : NSObject


/**
 *  AES128加密
 *
 *  @param plainText 原文
 *
 *  @return 加密好的字符串
 */
+ (NSString *)AES128Encrypt:(NSString *)plainText;
/**
 *  AES128解密
 *
 *  @param encryptText 密文
 *
 *  @return 明文
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText;

@end
