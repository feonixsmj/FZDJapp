//
//  FZDJMyWalletCashCell.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/9.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyWalletCashCell.h"

@interface FZDJMyWalletCashCell()

@end

@implementation FZDJMyWalletCashCell

- (IBAction)cashButtonDidClicked:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(withdrawMoney)]) {
        [self.delegate withdrawMoney];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
