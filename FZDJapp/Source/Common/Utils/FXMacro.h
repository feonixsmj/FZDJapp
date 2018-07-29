//
//  FXMacro.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#ifndef FXMacro_h
#define FXMacro_h

#define FX_SCREEN_SIZE                ([UIScreen mainScreen].bounds.size)
#define FX_SCREEN_WIDTH               ([UIScreen mainScreen].bounds.size.width)
#define FX_SCREEN_HEIGHT              ([UIScreen mainScreen].bounds.size.height)

#define IOS11_OR_LATER       ( [ systemVersionMajorVersion] >= 11.0 )
#define IOS10_OR_LATER       ( [ systemVersionMajorVersion] >= 10.0 )
#define IOS9_OR_LATER        ( [ systemVersionMajorVersion] >= 9.0 )
#define IOS8_OR_LATER        ( [ systemVersionMajorVersion] >= 8.0 )
#define IOS7_OR_LATER        ( [ systemVersionMajorVersion] >= 7.0 )

#define IOS10_OR_EARLIER    ( !IOS11_OR_LATER )
#define IOS9_OR_EARLIER        ( !IOS10_OR_LATER )
#define IOS8_OR_EARLIER        ( !IOS9_OR_LATER )
#define IOS7_OR_EARLIER        ( !IOS8_OR_LATER )

//当前设备屏幕与4.7英寸屏幕的比例
#define FX_SCREEN_SCALE_WITH_47_INCH   (FX_SCREEN_WIDTH/375.0F)
//获取当前设备屏幕相对于4.7英寸屏幕的长度
#define FX_SCALE_ZOOM(f)               ceilf(FX_SCREEN_SCALE_WITH_47_INCH * ((float)f))

//状态栏的高度
#define FX_STATUSBAR_SPACE             (IS_IPHONE_X ? 44.0f : 20.0f)
//导航栏视图高度(不包含status bar的高度)
#define FX_NAVIGATIONBAR_SPAGE         (44.0f)

#define FX_NAVIGATIONBAR_TOTAL_SPAGE   (FX_STATUSBAR_SPACE + FX_NAVIGATIONBAR_SPAGE)
//iPhone X底部栏的高度值
#define FX_BOTTOM_SPAGE                (34.0f)
// 普通全屏tableview高度
#define FX_TABLE_HEIGHT                (FX_SCREEN_HEIGHT - FX_NAVIGATIONBAR_TOTAL_SPAGE)


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
