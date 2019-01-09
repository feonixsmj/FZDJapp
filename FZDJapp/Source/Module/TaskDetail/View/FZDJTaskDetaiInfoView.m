//
//  FZDJTaskDetaiInfoView.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJTaskDetaiInfoView.h"

const CGFloat FZDJTaskDetaiProgressViewWidth = 121.0;

@interface FZDJTaskDetaiInfoView()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIView *progressMainView;

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressMainWidthConst;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@end


@implementation FZDJTaskDetaiInfoView

+(CGFloat)viewHeight{
    return 115.0f;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.progressMainView.layer.cornerRadius = 4;
    self.progressMainView.backgroundColor = [[UIColor fx_colorWithHexString:@"4DB2EE"] colorWithAlphaComponent:0.3f];
    self.progressView.layer.cornerRadius = 4;
}


- (void)setItem:(FZDJTaskDetailItem *)item{
    if (!item) {
        return;
    }
    
    self.priceLabel.text = item.price;
    self.title.text = item.title;
    self.countLabel.attributedText = item.countAttributedStr;
    self.beginTimeLabel.text = item.beginTimeText;
    self.endTimeLabel.text = item.endTimeText;
    
    CGFloat width = FX_SCALE_ZOOM(FZDJTaskDetaiProgressViewWidth);
    if (FX_SCREEN_WIDTH == 320) {
        width *= 0.8;
    }
    self.progressMainWidthConst.constant = width;
    self.progressWidthConst.constant = ceil(item.persent/100.0f * width);
}

@end
