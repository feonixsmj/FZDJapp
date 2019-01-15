//
//  FZDJQuestionDescView.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJQuestionDescView.h"
#import "FXImageView.h"

@interface FZDJQuestionDescView()

@end

@implementation FZDJQuestionDescView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.textView.fx_placeHolder = @"请填写申述描述";
    self.textView.fx_placeHolderColor = [UIColor fx_colorWithHexString:@"999999"];
}
@end
