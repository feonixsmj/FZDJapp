//
//  FZDJMainCell.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainCell.h"
#import "FZDJMainView.h"

@interface FZDJMainCell()

@property (nonatomic, strong) FZDJMainView *mainView;
@end

@implementation FZDJMainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self customInit];
    }
    return self;
}

- (void)customInit{
    self.mainView = [[NSBundle mainBundle]
                     loadNibNamed:@"FZDJMainView"
                     owner:self options:nil].lastObject;
    
    [self.contentView addSubview:self.mainView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setItem:(FZDJMainItem *)item{
    if (!item) {
        return ;
    }
    _item = item;
    self.mainView.item = item;
}

@end
