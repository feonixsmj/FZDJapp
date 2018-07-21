//
//  FZDJPeraonalListCell.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPeraonalListCell.h"
#import "FXImageView.h"

@interface FZDJPeraonalListCell ()

@property (weak, nonatomic) IBOutlet FXImageView *bgImageView;
@property (weak, nonatomic) IBOutlet FXImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelRightConst;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@end

@implementation FZDJPeraonalListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setItem:(FZDJPersonalListItem *)item{
    
    self.bgImageView.image = [UIImage imageNamed:item.bgImageName];
    self.iconImageView.image = [UIImage imageNamed:item.icImageName];
    self.lineView.image = [UIImage imageNamed:@"dj_xuxian_icon"];
    self.lineView.hidden = item.hiddenLine;
    
    self.titleLabel.text = item.title;
    self.descLabel.text = item.descStr;
    self.arrowIcon.hidden = item.hiddenArrow;
    
    self.descLabelRightConst.constant = item.hiddenArrow ? 10 : 30;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
