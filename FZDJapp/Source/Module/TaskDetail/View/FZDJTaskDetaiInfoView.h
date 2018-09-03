//
//  FZDJTaskDetaiInfoView.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZDJTaskDetailItem.h"

@interface FZDJTaskDetaiInfoView : UIView

@property (nonatomic, strong) FZDJTaskDetailItem *item;

+(CGFloat)viewHeight;
@end
