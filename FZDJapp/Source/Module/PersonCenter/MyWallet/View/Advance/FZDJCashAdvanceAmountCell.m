//
//  FZDJCashAdvanceAmountCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJCashAdvanceAmountCell.h"
@interface FZDJCashAdvanceAmountCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end



@implementation FZDJCashAdvanceAmountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textField.delegate  = self;
    self.textField.placeholder = @"请输入金额";
    self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.textField.returnKeyType = UIReturnKeyDone;
}

- (void)setItem:(FZDJCashAdvanceAmountItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.descLabel.text = item.descStr;
}

- (IBAction)allCashAdvanceAction:(id)sender {
    self.textField.text = self.item.totalAmount;
    self.item.advanceAmount = self.item.totalAmount;
    if (self.block) {
        self.block(YES);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.item.advanceAmount = textField.text;
    
    if (self.block) {
        self.block(textField.text.length > 0);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}

@end
