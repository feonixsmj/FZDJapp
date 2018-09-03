//
//  FZDJAppealHistoryCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealHistoryCell.h"
#import "FXImageView.h"
@interface FZDJAppealHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appealContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@property (weak, nonatomic) IBOutlet FXImageView *imageView1;
@property (weak, nonatomic) IBOutlet FXImageView *imageView2;
@property (weak, nonatomic) IBOutlet FXImageView *imageView3;
@property (weak, nonatomic) IBOutlet FXImageView *imageView4;
@end

@implementation FZDJAppealHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setItem:(FZDJAppealHistoryItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    self.timeLabel.text = item.time;
    self.appealContentLabel.text = item.contentStr;
    self.replyLabel.text = item.replyStr;
    
    self.imageView1.imageURL = item.imageUrl1;
    self.imageView2.imageURL = item.imageUrl2;
    self.imageView3.imageURL = item.imageUrl3;
    self.imageView4.imageURL = item.imageUrl4;
}

@end
