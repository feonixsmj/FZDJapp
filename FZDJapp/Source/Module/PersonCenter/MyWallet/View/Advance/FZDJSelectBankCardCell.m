//
//  FZDJSelectBankCardCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJSelectBankCardCell.h"
#import "FXImageView.h"

@interface FZDJSelectBankCardCell()
@property (weak, nonatomic) IBOutlet FXImageView *iconiMAGE;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@end

@implementation FZDJSelectBankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconiMAGE.defaultImage = @"dj_yhka_icon";
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(FZDJBanklistItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    if ([item.iconUrl hasPrefix:@"dj_"]) {
        self.iconiMAGE.image = [UIImage imageNamed:item.iconUrl];
    } else {
        self.iconiMAGE.imageURL = item.iconUrl;
    }
    
    self.bankNameLabel.text = item.bankName;
}
@end
