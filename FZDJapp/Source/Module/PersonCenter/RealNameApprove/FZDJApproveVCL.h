//
//  FZDJApproveVCL.h
//  FZDJapp
//
//  Created by FZYG on 2019/2/1.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZDJApproveVCL : FXBaseViewController
@property (nonatomic, copy) void(^saveBlock)(void);
@end

NS_ASSUME_NONNULL_END
