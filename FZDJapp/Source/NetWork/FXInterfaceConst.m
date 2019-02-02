//
//  FXInterfaceConst.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXInterfaceConst.h"



NSString *const kApiDomain = @"http://www.mobibounty.com";
NSString *const kCashOutDomain = @"http://localhost:7002";

NSString *const kApiBanner = @"/server/slider/query";
NSString *const kApiTaskQuery = @"/server/task/query";
NSString *const kApiTaskInfo = @"/server/task/get";
NSString *const kApiMyTaskInfo = @"/server/task/getTaskInst";
NSString *const kApiTaskTakeTask = @"/server/task/takeTask";
NSString *const kApiTaskQueryMyTask = @"/server/task/queryMyTask";
NSString *const kApiTaskGetTaskInst = @"/server/task/getTaskInst";
NSString *const kApiTaskQueryComplaint = @"/server/task/queryComplaint";
NSString *const kApiTaskUpLoadBase64Image = @"/upload/uploadBase64";
NSString *const kApiTaskComplaint = @"/server/task/complaint";
NSString *const kApiTaskOtherlogin = @"/server/login/doOtherlogin";
NSString *const kApiTaskDologin = @"/server/login/dologin";//手机登录
NSString *const kApiTaskGetLoginCode = @"/server/code/getCode";//获取登录验证码
NSString *const kApiUpdatePhone = @"/server/user/updatePhone";//绑定手机

NSString *const kApiTaskUserGet = @"/server/user/get";
NSString *const kApiUserEditInfo = @"/server/user/editInfo";
NSString *const kApiUserBinding = @"/server/user/binding";

NSString *const kApiMsgQuery    = @"/server/msg/query";
NSString *const kApiMsgRead     = @"/server/msg/read";
NSString *const kApiMsgReadALL  = @"/server/msg/readAll";

NSString *const kApiQueryProvince = @"/server/user/queryProvince";
NSString *const kApiQueryCity = @"/server/user/queryCity";
NSString *const kApiQueryOrgBank = @"/server/user/queryOrgBank";
NSString *const kApiQueryBank = @"/server/user/queryBank";
NSString *const kApiAddUserBank = @"/server/user/addUserBank";

NSString *const kApiGetWallet = @"/server/user/getWallet";
NSString *const kApitxsm = @"/server/sys/txsm";
NSString *const kApiQueryWalletDetail = @"/server/user/queryWalletDetail";

NSString *const kApiQueryMyBank = @"/server/user/queryMyBank";
NSString *const kApiDelUserBank = @"/server/user/delUserBank";

NSString *const kApiUserCashOut = @"/server/user/cashOut";

NSString *const kApiLXKF = @"/server/sys/lxkf";
NSString *const kApiqueryMyShare = @"/server/user/queryMyShare";

NSString *const kApiConfig = @"/server/sys/iossh";
NSString *const kApiEditShareCode = @"/server/user/editShareCode";
NSString *const kApiShareCodeDesc = @"/server/sys/yqsm";
NSString *const kApiAboutUsDesc = @"/server/sys/gywm";

NSString *const kApiUnreadMessageCount = @"/server/msg/count";

NSString *const kApiCheckUpdate = @"/server/version/versionIos";
NSString *const kApiAppealDesc = @"/server/sys/sstksm";
NSString *const kApiUpdateZFB = @"/server/user/updateZfb";
NSString *const kApiUserAuth = @"/server/user/auth";
