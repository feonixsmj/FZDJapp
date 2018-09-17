//
//  FZDJBankListCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankListCell.h"
#import "FXImageView.h"

@interface FZDJBankListCell()

@property (weak, nonatomic) IBOutlet FXImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel;
@property (weak, nonatomic) IBOutlet UIView *cardBgView;
@end

@implementation FZDJBankListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.cornerRadius = 41 / 2;
    self.icon.clipsToBounds = YES;
    
    self.cardBgView.layer.cornerRadius = 5;
    self.cardBgView.clipsToBounds = YES;
    
    self.contentView.backgroundColor = [UIColor fx_colorWithHexString:@"#394960"];
}

- (void)setItem:(FZDJBanklistItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    self.icon.imageURL = item.iconUrl;
    self.bankNameLabel.text = item.bankName;
    self.bankNumLabel.text = item.bankNumber;
    self.cardBgView.backgroundColor = [UIColor fx_colorWithHexString:item.bgColorHexStr];
    
}
@end
