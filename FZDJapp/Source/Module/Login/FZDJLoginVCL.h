//
//  FZDJLoginVCL.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZDJLoginVCLDelegate <NSObject>

- (void)closeLoginVCL;
@end

@interface FZDJLoginVCL : UIViewController

@property(nonatomic, weak) id<FZDJLoginVCLDelegate> delegate;
@end
