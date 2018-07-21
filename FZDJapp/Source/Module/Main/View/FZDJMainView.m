//
//  FZDJMainView.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainView.h"
#import "FXImageView.h"
#import "FZDJMainItem.h"

const CGFloat FZDJMainViewProgressViewWidth = 140.0;

@interface FZDJMainView()

@property (weak, nonatomic) IBOutlet FXImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (weak, nonatomic) IBOutlet UIView *progressMainView;

@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidthConst;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet FXImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FZDJMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icon.image = [UIImage imageNamed:@"clock_icon"];
    self.progressMainView.layer.cornerRadius = 4;
    self.progressMainView.backgroundColor = [[UIColor fx_colorWithHexString:@"4DB2EE"] colorWithAlphaComponent:0.3f];
    
    self.progressView.layer.cornerRadius = 4;
    self.mainImageView.image = [UIImage imageNamed:@"dj_default_image"];
    self.mainImageView.layer.cornerRadius = 4;
}

- (void)setItem:(FZDJMainItem *)item{
    if (!item) {
        return ;
    }
    
    _item = item;
    self.timeLabel.text = item.title;
    self.subTitle.text = item.subTitle;
    self.timeLabel.text = item.timeText;
    self.price.text = item.price;
    self.numLabel.text = item.count;
    self.progressWidthConst.constant = ceil(item.persent/100.0f * FZDJMainViewProgressViewWidth);
    
}
@end
