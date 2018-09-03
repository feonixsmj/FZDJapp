//
//  FZDJPersonalInfoCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalInfoCell.h"
#import "FXImageView.h"
#import "FZDJPersonalInfoItem.h"

@interface FZDJPersonalInfoCell()

@property (weak, nonatomic) IBOutlet FXImageView *avatarBgImageView;

@property (weak, nonatomic) IBOutlet FXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet FXImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation FZDJPersonalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self customInit];
//    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)setItem:(FZDJPersonalInfoItem *)item{
    
    self.avatarImageView.imageURL = item.avatarUrl;
    self.nameLabel.text = item.nickName;
    NSString *seximageName = item.isGirl ? @"dj_girl_icon" :@"dj_man_icon";
    self.sexImageView.image = [UIImage imageNamed:seximageName];
}

- (void)customInit{
    self.avatarBgImageView.image = [UIImage imageNamed:@"dj_touxiang_bg"];
}

//修改头像
- (IBAction)modifyAvatarMaskBtnAction:(id)sender {
    if (self.delegate && [self.delegate
            respondsToSelector:@selector(personalCellActionForwarder:)]) {
        [self.delegate personalCellActionForwarder:FZDJCellActionTypeModifyAvatar];
    }

}

//修改个人信息
- (IBAction)modifyPersoalInfoBtnAction:(id)sender {
    if (self.delegate && [self.delegate
                          respondsToSelector:@selector(personalCellActionForwarder:)]) {
        [self.delegate personalCellActionForwarder:FZDJCellActionTypeModifyPersonalInfo];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
