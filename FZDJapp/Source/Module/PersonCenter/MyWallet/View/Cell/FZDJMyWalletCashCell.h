//
//  FZDJMyWalletCashCell.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/9.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZDJMyWalletCashCellDelegate<NSObject>

/**
 提现
 */
- (void)withdrawMoney;
@end

@interface FZDJMyWalletCashCell : UITableViewCell

@property (nonatomic, weak) id<FZDJMyWalletCashCellDelegate> delegate;
@end
