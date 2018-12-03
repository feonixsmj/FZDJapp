//
//  FXMyTaskListCell.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZDJMyTaskItem.h"

@protocol FXMyTaskListCellDelegate <NSObject>
-(void)gotoAppealDetailPage:(FZDJMyTaskItem *)item;

@end

@interface FXMyTaskListCell : UITableViewCell

@property (nonatomic, strong) FZDJMyTaskItem *item;
@property (nonatomic, weak) id<FXMyTaskListCellDelegate> delegate;
@end
