//
//  FZDJBankCardCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankCardCell.h"

@interface FZDJBankCardCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FZDJBankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(FZDJBankCardItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    self.titleLabel.text =item.title;
    self.contentLabel.text = item.contentText;
}

@end
