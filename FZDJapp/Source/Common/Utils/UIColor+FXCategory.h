//
//  UIColor+FXCategory.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FXCategory)

+ (instancetype)fx_colorWithHexString:(NSString *)hexStr;

/**
 * 绘制渐变色颜色的方法
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end
