//
//  FZDJDataModelSingleton.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXSingleton.h"
#import "FZDJUserInfo.h"

@interface FZDJDataModelSingleton : NSObject
@singleton(FZDJDataModelSingleton)

@property (nonatomic, strong) FZDJUserInfo *userInfo;

- (void)save;
@end
