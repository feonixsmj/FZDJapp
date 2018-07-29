//
//  FZDJPersonalBaseCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalBaseCell.h"

@implementation FZDJPersonalBaseCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBgColorStyle];
        [self customInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBgColorStyle];
    // Initialization code
    [self customInit];
}

- (void)setBgColorStyle{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)customInit{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
