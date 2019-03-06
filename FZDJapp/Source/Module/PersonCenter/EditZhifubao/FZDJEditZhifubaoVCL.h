//
//  FZDJEditZhifubaoVCL.h
//  FZDJapp
//
//  Created by FZYG on 2019/1/23.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZDJEditZhifubaoVCL : FXBaseViewController
@property (nonatomic, assign) BOOL keepAlive;
@property (nonatomic, copy) void(^closeBlock)(void);
@end

NS_ASSUME_NONNULL_END
