//
//  FZDJTaskCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJTaskCell.h"



@implementation FZDJTaskCell


- (void)customInit{
    self.mainView = [[NSBundle mainBundle]
                     loadNibNamed:@"FZDJPersonalTaskView"
                     owner:self options:nil].lastObject;
    
    [self.contentView addSubview:self.mainView];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    
}


@end
