//
//  FZDJUserProtocolView.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/5.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJUserProtocolView.h"

@interface FZDJUserProtocolView ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation FZDJUserProtocolView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.textView.inputView = [UIView new];
    self.textView.editable = NO;
    
    [self bringSubviewToFront:self.closeBtn];
}


- (IBAction)closeBtnDidClicked:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

@end
