//
//  FZDJIDCardCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJIDCardCell.h"
@interface FZDJIDCardCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1WidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2WidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn3WidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn4WidthConst;


@end
@implementation FZDJIDCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)takePhotoAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.takePhotoblock) {
        self.takePhotoblock(btn);
    }
}

@end
