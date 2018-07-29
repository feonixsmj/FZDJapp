//
//  FZDJPersonalTaskView.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/7.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalTaskView.h"
#import "FXImageView.h"

typedef NS_ENUM(NSUInteger, FZDJPersonalTaskViewTag) {
    FZDJPersonalTaskViewTagWallet = 100,//钱包
    FZDJPersonalTaskViewTagTask = 200,//任务
    FZDJPersonalTaskViewTagCode = 300,//邀请码
};

@interface FZDJPersonalTaskView ()

@property (weak, nonatomic) IBOutlet FXImageView *bgImageView;
@end

@implementation FZDJPersonalTaskView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bgImageView.image = [UIImage imageNamed:@"dj_card_bg"];
}

- (IBAction)buttonDidClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    
    if (self.delegate && [self.delegate
                respondsToSelector:@selector(personalCellActionForwarder:)]) {
        switch (tag) {
            case FZDJPersonalTaskViewTagWallet:
                [self.delegate personalCellActionForwarder:
                                                    FZDJCellActionTypeWallet];
                break;
            case FZDJPersonalTaskViewTagTask:
                [self.delegate personalCellActionForwarder:
                                                    FZDJCellActionTypeTask];
                break;
            case FZDJPersonalTaskViewTagCode:
                [self.delegate personalCellActionForwarder:
                                            FZDJCellActionTypeInvitationCode];
                break;
                
            default:
                break;
        }
    }
}

@end
