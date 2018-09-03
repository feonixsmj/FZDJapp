//
//  FZDJMyTaskListVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJMyTaskInfoVO.h"

@interface FZDJMyTaskListVo : NSObject

@property (nonatomic, strong) NSArray <FZDJMyTaskInfoVO *> *body;
@end
