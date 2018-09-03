//
//  FZDJBankCardIdentityCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankCardIdentityCell.h"

@interface FZDJBankCardIdentityCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end


@implementation FZDJBankCardIdentityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textField.delegate = self;
}

- (void)setItem:(FZDJBankCardIdentityItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.titleLabel.text = item.title;
    self.textField.placeholder = item.placeholder;
    
    if (item.content.length > 0) {
        self.textField.text = item.content;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.item.content = textField.text;
}

@end
