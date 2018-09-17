//
//  FZDJIDCardCell.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FZDJIDCardCellTakePhotosBlock)(UIButton *btn);

@interface FZDJIDCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (nonatomic, copy) FZDJIDCardCellTakePhotosBlock takePhotoblock;
@end
