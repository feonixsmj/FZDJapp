//
//  FZDJAppealTaskInfoView.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealTaskInfoView.h"
#import "FXImageView.h"

@interface FZDJAppealTaskInfoView ()
@property (weak, nonatomic) IBOutlet FXImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation FZDJAppealTaskInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.clipsToBounds = YES;
}

- (void)setItem:(FZDJMyTaskItem *)item{
    if(!item) {
        return;
    }
    self.iconImageView.imageURL = item.iconURL;
    self.titleLabel.text = item.title;
    self.subTitle.text = item.subTitle;
    self.timeLabel.text = item.time;
    self.priceLabel.text = item.price;
    
}


@end
