//
//  FXBadgeImageView.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FXBadgeImageView.h"

@implementation FXBadgeImageView

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 21, 15)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self init];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (backgroundImage && backgroundImage != _backgroundImage) {
        _backgroundImage = backgroundImage;
        self.image = backgroundImage;
    }
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue && ![badgeValue isEqualToString:_badgeValue]) {
        _badgeValue = badgeValue;
        [self refresh];
    }
}

- (void)refresh {
    if (nil == self.badgeLab.superview) {
        [self addSubview:self.badgeLab];
    }
    
    [self.badgeLab setText:self.badgeValue];
    if (self.badgeValue.length == 0) {
        [self setHidden:YES];
    }
    else {
        [self setHidden:NO];
    }
}

- (void)showMore {
    self.badgeLab.text = nil;
    [self.badgeLab removeFromSuperview];
}

#pragma mark
#pragma getter

- (UILabel *)badgeLab {
    if (!_badgeLab) {
        _badgeLab = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, self.width - 2, self.height - 2)];
        _badgeLab.font = [UIFont systemFontOfSize:9.0f];
        _badgeLab.textColor = [UIColor whiteColor];
        _badgeLab.textAlignment = NSTextAlignmentCenter;
        _badgeLab.backgroundColor = [UIColor clearColor];
    }
    
    return _badgeLab;
}


@end
