//
//  FZDJBaseBVO.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJBaseBVO : NSObject

@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, copy) NSString *createUser;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSTimeInterval updateTime;
@property (nonatomic, copy) NSString *updateUser;
@property (nonatomic, copy) NSString *isEnable;
@end
