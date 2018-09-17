//
//  FZDJSelectBankCardView.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZDJSelectBankCardViewDelegate<NSObject>
- (void)FZDJSelectBankCardViewDidSelectedIndexPath:(NSIndexPath *)indexPath;
@end

@interface FZDJSelectBankCardView : UIView
@property (nonatomic, weak) id<FZDJSelectBankCardViewDelegate> delegate;
@property (nonatomic, strong) UIView *contentView;
//取消按钮
@property (nonatomic, strong)UIButton *cancelButton;
//选择器的高度
@property (nonatomic, assign)CGFloat contentViewHeight;

@property (nonatomic, strong) NSArray *dataArray;
/**
 *  pickerView的显示
 */
- (void)show;

/**
 *  移除pickerView
 */
- (void)disMiss;
@end
