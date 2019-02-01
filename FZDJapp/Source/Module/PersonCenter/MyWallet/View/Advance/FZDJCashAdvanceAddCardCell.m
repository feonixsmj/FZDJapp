//
//  FZDJCashAdvanceAddCardCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJCashAdvanceAddCardCell.h"
#import "FXImageView.h"

@interface FZDJCashAdvanceAddCardCell()

@property (weak, nonatomic) IBOutlet FXImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *bankNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNumberLabel;
@end
@implementation FZDJCashAdvanceAddCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImage.image = [UIImage imageNamed:@"dj_advance_bg"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(FZDJCashAdvanceAddCardItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    if (item.iconUrl.length > 0) {
        self.iconImage.imageURL = item.iconUrl;
    }
    if (item.isWeixin) {
        self.iconImage.image = [UIImage imageNamed:@"dj_advance_weixin_icon"];
    }
    if (item.isZhifubao) {
        self.iconImage.image = [UIImage imageNamed:@"dj_zhifubao_icon"];
    }
    
    if (item.bankName.length > 0) {
        self.bankNamelabel.text = item.bankName;
    }
    
    if (item.bankDese) {
        self.bankNumberLabel.text = item.bankDese;
    }

}

@end
