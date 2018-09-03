//
//  FXMyTaskViewController.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseTableViewController.h"

UIKIT_EXTERN const NSString *FXTaskCompleted;
UIKIT_EXTERN const NSString *FXTaskNoCompleted;

@interface FXMyTaskViewController : FXBaseTableViewController

/**
 页面标识
 */
@property (nonatomic,copy) NSString *pageIdetify;
@end
