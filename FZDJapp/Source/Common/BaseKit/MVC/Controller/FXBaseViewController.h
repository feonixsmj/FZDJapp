//
//  FXBaseViewController.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/26.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXBaseModel;
@interface FXBaseViewController : UIViewController

@property (nonatomic, strong) FXBaseModel *model;

-(void)loadItem;
@end
