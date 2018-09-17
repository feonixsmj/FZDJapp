//
//  NSError+FXExtension.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/5.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "NSError+FXExtension.h"

@implementation NSError (FXExtension)

-(NSString *)errorMsg{
    NSDictionary *errorInfo = self.userInfo;
    return errorInfo[@"NSLocalizedDescription"];
}
@end
