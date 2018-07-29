//
//  FZDJHeaderImageView.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJHeaderImageView.h"

CGFloat const FZDJHeaderImageViewHeight = 191.0f;

@implementation FZDJHeaderImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (CGRectEqualToRect(frame, CGRectZero)){
            self.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FZDJHeaderImageViewHeight);
            self.backgroundColor = [UIColor redColor];
            [self customInit];
        }
    }
    return self;
}

- (void)customInit{
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.image = [UIImage imageNamed:@"dj_header_bg"];
}

@end
