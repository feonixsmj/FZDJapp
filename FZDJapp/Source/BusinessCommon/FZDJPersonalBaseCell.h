//
//  FZDJPersonalBaseCell.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZDJPersonalBaseCell : UITableViewCell

@property (nonatomic, weak) id <FZDJPersonalCellActionProtocol> delegate;

- (void)customInit;
@end
