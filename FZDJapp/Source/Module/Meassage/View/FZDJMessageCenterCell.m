//
//  FZDJMessageCenterCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterCell.h"
#import "FXImageView.h"
#import "FZDJMessageCenterItem.h"

@interface FZDJMessageCenterCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *redDotView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation FZDJMessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setupViews{
    self.bgView.layer.cornerRadius = 4.0f;
    
    self.redDotView.layer.cornerRadius = self.redDotView.height / 2;
    self.redDotView.layer.masksToBounds = YES;
}

- (void)setItem:(FZDJMessageCenterItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.titleLabel.text = item.title;
    self.timeLabel.text = item.time;
    self.subTitleLabel.text = item.subTitle;
    self.redDotView.hidden = item.isRead;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
