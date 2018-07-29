//
//  FXCrypto.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXCrypto.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "水电费";

@implementation FXCrypto

+ (NSString *)md5:(NSString *)string {
    
    if (string == nil || [string length] == 0)
    {
        return @"";
    }
    
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

// 去除第一个字符后解码
+ (NSString*)base64decodeMBString:(NSString *)str
{
    if (str == nil || [str length] == 0)
    {
        return nil;
    }
    // 加密方式 0：表示不加密
    NSRange range = NSMakeRange(0, 1);
    NSString *encryptFlag = [str substringWithRange:range];
    
    NSString *content = [str substringFromIndex:1];
    
    if ([encryptFlag isEqualToString:@"0"]) {
        
        return [FXCrypto base64decode:content];
    }
    
    return content;
}



+ (NSString*)base64decode:(NSString *)str
{
    if (str == nil || [str length] == 0)
    {
        return nil;
    }
    NSData* data = [GTMBase64 decodeString:str];
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString*)base64encode:(NSString*)input
{
    if ([input length] == 0)
        return @"";
    
    const char *source = [input UTF8String];
    int strlength  = (int)strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
