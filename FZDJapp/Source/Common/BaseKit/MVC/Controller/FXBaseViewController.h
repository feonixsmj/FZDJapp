//
//  FXBaseViewController.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBaseModel.h"

@interface FXBaseViewController : UIViewController

@property (nonatomic, strong) FXBaseModel *model;
@property (nonatomic, assign) BOOL hiddenNavigationBar;
@property (nonatomic, assign) BOOL isTransparentBar;

-(void)bringCloseButtonToFront;

#pragma mark ================ 子类重写 ================
-(void)loadItem;
- (void)setupViews;
@end
