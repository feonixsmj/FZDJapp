//
//  FZDJUserProtocolWindow.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/5.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJUserProtocolWindow.h"
#import "FZDJUserProtocolView.h"

@interface FZDJUserProtocolWindow ()

@property (nonatomic,strong) FZDJUserProtocolView *protocolView;
@end

@implementation FZDJUserProtocolWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = NO;
        self.windowLevel = UIWindowLevelStatusBar - 2;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
    }
    return self;
}

- (void)show {
    if (!self.protocolView.superview) {
        self.hidden = NO;
        self.windowLevel = UIWindowLevelStatusBar - 2;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.protocolView];
        
        [self.protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(300, 440));
        }];
    }
}

- (FZDJUserProtocolView *)protocolView{
    if (!_protocolView) {
        FZDJUserProtocolView *protocolView = [[[NSBundle mainBundle] loadNibNamed:@"FZDJUserProtocolView" owner:self options:nil] lastObject];
        
        __weak typeof(self) weak_self = self;
        protocolView.closeBlock = ^{
            [weak_self hide];
        };
        
        _protocolView = protocolView;
    }
    return _protocolView;
}


- (void)hide {
    [self resignKeyWindow];
    self.windowLevel = -1000;
    self.hidden = YES;
    
    [self.protocolView removeFromSuperview];
    
    [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
    
    if (self.closeblock) {
        self.closeblock();
    }
}

@end
