//
//  FXInterfaceConst.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Dev 0

UIKIT_EXTERN NSString *const kApiDomain;

UIKIT_EXTERN NSString *const kApiBanner;
UIKIT_EXTERN NSString *const kApiTaskQuery;
UIKIT_EXTERN NSString *const kApiTaskInfo;
UIKIT_EXTERN NSString *const kApiTaskTakeTask;
UIKIT_EXTERN NSString *const kApiTaskQueryMyTask;//查询我的任务
UIKIT_EXTERN NSString *const kApiTaskGetTaskInst;//我的任务详情
UIKIT_EXTERN NSString *const kApiTaskQueryComplaint;//申诉历史
UIKIT_EXTERN NSString *const kApiTaskUpLoadBase64Image;//上传base64图片
UIKIT_EXTERN NSString *const kApiTaskComplaint;//提交申述

UIKIT_EXTERN NSString *const kApiTaskOtherlogin;//第三方登录
UIKIT_EXTERN NSString *const kApiTaskDologin;//手机登录
UIKIT_EXTERN NSString *const kApiTaskGetLoginCode;//获取登录验证码

UIKIT_EXTERN NSString *const kApiTaskUserGet;//查询用户信息
UIKIT_EXTERN NSString *const kApiUserEditInfo;//修改基本信息
UIKIT_EXTERN NSString *const kApiUserBinding;//第三方绑定

UIKIT_EXTERN NSString *const kApiMsgQuery;      //消息列表
UIKIT_EXTERN NSString *const kApiMsgRead;       //单条已读
UIKIT_EXTERN NSString *const kApiMsgReadALL;    //全部已读

UIKIT_EXTERN NSString *const kApiQueryProvince; //查询省
UIKIT_EXTERN NSString *const kApiQueryCity;     //查询市
UIKIT_EXTERN NSString *const kApiQueryBank;     //查询银行列表
UIKIT_EXTERN NSString *const kApiAddUserBank;   //添加用户银行
