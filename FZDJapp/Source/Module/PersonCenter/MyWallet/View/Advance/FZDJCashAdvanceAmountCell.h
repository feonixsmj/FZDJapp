//
//  FZDJCashAdvanceAmountCell.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZDJCashAdvanceAmountItem.h"

typedef void(^FZDJCashAdvanceAmountCellBlock)(BOOL isEnableAdvance);

@interface FZDJCashAdvanceAmountCell : UITableViewCell

@property (nonatomic, strong) FZDJCashAdvanceAmountItem *item;
@property (nonatomic, copy) FZDJCashAdvanceAmountCellBlock block;
@end
