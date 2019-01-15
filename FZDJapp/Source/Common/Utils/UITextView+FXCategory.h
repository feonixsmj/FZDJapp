//
//  UITextView+FXCategory.h
//  FZDJapp
//
//  Created by smj on 2019/1/15.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (FXCategory)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *fx_placeHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *fx_placeHolderColor;
@end


