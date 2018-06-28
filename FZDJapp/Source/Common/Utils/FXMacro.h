//
//  FXMacro.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/25.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#ifndef FXMacro_h
#define FXMacro_h

#define FX_SCREEN_SIZE                ([UIScreen mainScreen].bounds.size)
#define FX_SCREEN_WIDTH               ([UIScreen mainScreen].bounds.size.width)
#define FX_SCREEN_HEIGHT              ([UIScreen mainScreen].bounds.size.height)

#define IOS11_OR_LATER       ( [OMTSystemInfo systemVersionMajorVersion] >= 11.0 )
#define IOS10_OR_LATER       ( [OMTSystemInfo systemVersionMajorVersion] >= 10.0 )
#define IOS9_OR_LATER        ( [OMTSystemInfo systemVersionMajorVersion] >= 9.0 )
#define IOS8_OR_LATER        ( [OMTSystemInfo systemVersionMajorVersion] >= 8.0 )
#define IOS7_OR_LATER        ( [OMTSystemInfo systemVersionMajorVersion] >= 7.0 )

#define IOS10_OR_EARLIER    ( !IOS11_OR_LATER )
#define IOS9_OR_EARLIER        ( !IOS10_OR_LATER )
#define IOS8_OR_EARLIER        ( !IOS9_OR_LATER )
#define IOS7_OR_EARLIER        ( !IOS8_OR_LATER )

#define IS_IPHONE4 (IS_SCREEN_35_INCH)
#define IS_IPHONE5 (IS_SCREEN_4_INCH)
#define IS_IPHONE6 (IS_SCREEN_47_INCH)
#define IS_IPHONE6_PLUS (IS_SCREEN_55_INCH)
#define IS_IPHONE_X (IS_SCREEN_IPHONE_X_58_INCH)

#define IS_SCREEN_IPHONE_X_58_INCH      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_55_INCH               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define IS_SCREEN_47_INCH               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_4_INCH                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_IPAD_35_INCH          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) : NO)
#endif /* FXMacro_h */
