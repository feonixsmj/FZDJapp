//
//  FZDJAppealViewController.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseTableViewController.h"

#import "FZDJMyTaskItem.h"

@interface FZDJAppealViewController : FXBaseTableViewController

@property (nonatomic, strong) FZDJMyTaskItem *taskItem;

- (void)uploadImage:(UIImage *)image;
@end
