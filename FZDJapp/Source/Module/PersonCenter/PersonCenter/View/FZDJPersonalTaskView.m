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
@property (weak, nonatomic) IBOutlet UIButton *taskBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *walletBtn;

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

    [self addConstraints];
}

- (void)addConstraints{
    [self.bgImageView setNeedsUpdateConstraints];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(122);
    }];
    
    [self.bgImageView updateConstraints];
    
    [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 70));
        make.left.mas_equalTo(self.bgImageView).offset(31);
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(26);
    }];
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    if (dm.userInfo.isInReview) {
        [self.taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 70));
            make.right.mas_equalTo(self.bgImageView.mas_right).offset(-29);
            make.top.mas_equalTo(self.bgImageView.mas_top).offset(26);
        }];
        self.codeBtn.hidden = YES;
    } else{
        self.codeBtn.hidden = NO;
        [self.taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 70));
            CGFloat left = (FX_SCREEN_WIDTH - 10 - 60)/2;
            make.left.mas_equalTo(self.bgImageView.mas_left).offset(left);
//            make.center.mas_equalTo(self.bgImageView.center);
            make.top.mas_equalTo(self.bgImageView.mas_top).offset(26);
        }];
        
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 70));
            make.right.mas_equalTo(self.bgImageView.mas_right).offset(-29);
            make.top.mas_equalTo(self.bgImageView.mas_top).offset(26);
        }];
    }
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
