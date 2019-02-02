//
//  FZDJPersonalListItem.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalListItem.h"

@implementation FZDJPersonalListItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.descStr = @"";
        self.hiddenArrow = NO;
        self.bgImageName = @"dj_card_mid";
        self.hiddenLine = NO;
    }
    return self;
}

- (void)setBgImageName:(NSString *)bgImageName{
    _bgImageName = bgImageName;
    if ([bgImageName isEqualToString:@"dj_card_bottom"]) {
        self.hiddenLine = YES;
    }
}
@end
