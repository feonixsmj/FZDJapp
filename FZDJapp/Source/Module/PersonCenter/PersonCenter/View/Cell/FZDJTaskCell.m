//
//  FZDJTaskCell.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJTaskCell.h"



@implementation FZDJTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

//    [self customInit];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.backgroundColor = [UIColor clearColor];
//        [self customInit];
    }
    return self;
}

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
    
//    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView);
//        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
//        make.bottom.mas_equalTo (self.contentView.mas_bottom);
//        make.right.mas_equalTo (self.contentView.mas_right).offset(-10);
//    }];
}


@end
