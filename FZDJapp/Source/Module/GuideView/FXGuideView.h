//
//  FXGuideView.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/25.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXGuideView : UIView

/**
 *  FXGuideView (新手引导页)
 *
 *  @param frame      frame
 *  @param imageNameArray 引导页图片数组(NSString)
 *  @param isHidden   开始体验按钮是否隐藏(YES:隐藏-引导页完成自动进入APP首页;
                            NO:不隐藏-引导页完成点击开始体验按钮进入APP主页)
 */
- (instancetype)initWithFrame:(CGRect)frame
                imageNameArray:(NSArray<NSString *> *)imageNameArray
                buttonIsHidden:(BOOL)isHidden;

@end
