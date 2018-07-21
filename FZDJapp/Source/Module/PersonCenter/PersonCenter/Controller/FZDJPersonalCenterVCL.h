//
//  FZDJPersonalCenterVCL.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseTableViewController.h"

@protocol FZDJPersonalCenterVCLDelegate<NSObject>
- (void)fzdjPersonalCenterVCLClosePage;

@end

@interface FZDJPersonalCenterVCL : FXBaseTableViewController

@property (nonatomic, weak) id <FZDJPersonalCenterVCLDelegate> delegate;

@end
