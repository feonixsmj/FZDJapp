//
//  FXInterfaceConst.m
//  FZDJapp
//
//  Created by suminjie on 2018/6/26.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXInterfaceConst.h"


#if DEBUG == 1
    #if DEV == 1
        NSString *const kApiDomain = @"http://192.168.10.10:8080";
    #else
        NSString *const kApiDomain = @"http://www.baidu.com";
    #endif

#else
    NSString *const kApiDomain = @"http://www.baidu.com";
#endif
