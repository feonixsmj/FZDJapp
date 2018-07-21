//
//  FZDJAmountDetailsCell.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/11.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAmountDetailsCell.h"
#import "FZDJAmountDetailsItem.h"

@interface FZDJAmountDetailsCell()

@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation FZDJAmountDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(FZDJAmountDetailsItem *)item{
    
    _item = item;
    self.titileLabel.text = item.title;
    self.dateLabel.text = item.time;
    self.priceLabel.text = item.price;
}

@end
