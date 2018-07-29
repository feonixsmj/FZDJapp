
//
//  FZDJInvitationCodeCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/18.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJInvitationCodeCell.h"
#import "FZDJInvitationCodeItem.h"

@interface FZDJInvitationCodeCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@end

@implementation FZDJInvitationCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarImageView.layer.cornerRadius = 22;
    self.avatarImageView.clipsToBounds = YES;
    self.contentView.backgroundColor = [[UIColor fx_colorWithHexString:@"#56B5D6"]
                                        colorWithAlphaComponent:0.1f];
}

- (void)setItem:(FZDJInvitationCodeItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.avatarImageView.image = [UIImage imageNamed:@"InvitationCode_avatar"];
    self.nickName.text = item.name;
    self.timelabel.text = item.time;
}
@end
