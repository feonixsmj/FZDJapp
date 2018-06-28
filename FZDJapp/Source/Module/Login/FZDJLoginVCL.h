//
//  FZDJLoginVCL.h
//  FZDJapp
//
//  Created by suminjie on 2018/6/25.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZDJLoginVCLDelegate <NSObject>

- (void)closeLoginVCL;
@end

@interface FZDJLoginVCL : UIViewController

@property(nonatomic, weak) id<FZDJLoginVCLDelegate> delegate;
@end
