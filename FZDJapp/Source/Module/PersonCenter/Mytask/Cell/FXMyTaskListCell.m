//
//  FXMyTaskListCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXMyTaskListCell.h"
#import "FXImageView.h"

@interface FXMyTaskListCell()

@property (weak, nonatomic) IBOutlet FXImageView *cardBgImageView;
@property (weak, nonatomic) IBOutlet FXImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *clockIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation FXMyTaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cardBgImageView.image = [UIImage imageNamed:@"dj_task_card_bg"];
    self.cardBgImageView.backgroundColor = [UIColor clearColor];
    self.clockIcon.image = [UIImage imageNamed:@"dj_task_clock_icon"];
    self.iconImageView.layer.cornerRadius = 4.0f;
    self.iconImageView.clipsToBounds = YES;
    
}

- (void)setItem:(FZDJMyTaskItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.iconImageView.imageURL = item.iconURL;
    self.titlelabel.text = item.title;
    self.subTitleLabel.text = item.subTitle;
    self.priceLabel.text = item.price;
    
    self.timeLabel.text = item.time;
    if (item.time.length > 0) {
        self.clockIcon.hidden = NO;
    } else {
        self.clockIcon.hidden = YES;
    }
    
    if (item.status != FXMyTaskItemStatusNone) {
        NSInteger status = item.status;
        NSString *imageName = [self getImageName:status];
        self.statusImageView.image = [UIImage imageNamed:imageName];
    }
}

- (NSString *)getImageName:(FXMyTaskItemStatus)status{
    switch (status) {
        case FXMyTaskItemStatusClose:
            return @"dj_task_close_icon";
            break;
        case FXMyTaskItemStatusReply:
            return @"dj_task_reply_icon";
            break;
        case FXMyTaskItemStatusAppeal:
            return @"dj_task_appeal_icon";
            break;
        case FXMyTaskItemStatusAppealing:
            return @"dj_task_appealing_icon";
            break;
            
        default:
            break;
    }
    return @"";
}

- (IBAction)buttonDidClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoAppealDetailPage:)]) {
        [self.delegate gotoAppealDetailPage:self.item];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
