//
//  FZDJBankInfoListVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/3.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBankInfoVO.h"

@interface FZDJBankInfoListVo : NSObject
@property (nonatomic, strong) NSArray<FZDJBankInfoVO *> *body;
@end