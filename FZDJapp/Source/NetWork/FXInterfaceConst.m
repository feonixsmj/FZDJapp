//
//  FXInterfaceConst.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXInterfaceConst.h"


#if DEBUG == 1
    #if DEV == 1
        NSString *const kApiDomain = @"http://www.mobibounty.com";
    #else
        NSString *const kApiDomain = @"http://www.mobibounty.com";
    #endif

#else
    NSString *const kApiDomain = @"http://www.mobibounty.com";
#endif

NSString *const kApiBanner = @"/server/slider/query";
NSString *const kApiTaskQuery = @"/server/task/query";
NSString *const kApiTaskInfo = @"/server/task/get";
NSString *const kApiTaskTakeTask = @"/server/task/takeTask";
