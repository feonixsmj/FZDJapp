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
NSString *const kApiTaskQueryMyTask = @"/server/task/queryMyTask";
NSString *const kApiTaskGetTaskInst = @"/server/task/getTaskInst";
NSString *const kApiTaskQueryComplaint = @"/server/task/queryComplaint";
NSString *const kApiTaskUpLoadBase64Image = @"/upload/uploadBase64";
NSString *const kApiTaskComplaint = @"/server/task/complaint";
NSString *const kApiTaskOtherlogin = @"/server/login/doOtherlogin";
NSString *const kApiTaskDologin = @"/server/login/dologin";//手机登录
NSString *const kApiTaskGetLoginCode = @"/server/code/getCode";//获取登录验证码

NSString *const kApiTaskUserGet = @"/server/user/get";
NSString *const kApiUserEditInfo = @"/server/user/editInfo";
NSString *const kApiUserBinding = @"/server/user/binding";

NSString *const kApiMsgQuery    = @"/server/msg/query";
NSString *const kApiMsgRead     = @"/server/msg/read";
NSString *const kApiMsgReadALL  = @"/server/msg/readAll";

NSString *const kApiQueryProvince = @"/server/user/queryProvince";
NSString *const kApiQueryCity = @"/server/user/queryCity";
NSString *const kApiQueryBank = @"/server/user/queryBank";
NSString *const kApiAddUserBank = @"/server/user/addUserBank";
