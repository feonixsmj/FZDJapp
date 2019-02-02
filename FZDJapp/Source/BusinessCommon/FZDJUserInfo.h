//
//  FZDJUserInfo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FZDJUserInfoLoginType) {
    FZDJUserInfoLoginTypeWechat = 1,
    FZDJUserInfoLoginTypeQQ ,
    FZDJUserInfoLoginTypeWeibo,
    FZDJUserInfoLoginTypePhone
};


@interface FZDJUserInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, assign) NSInteger sexInteger; //1 男 0女
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *openid;//登录回调
@property (nonatomic, copy) NSString *userNo;//用户编码

@property (nonatomic, assign) FZDJUserInfoLoginType loginType;

@property (nonatomic, copy) NSString *weixinNickName;
@property (nonatomic, copy) NSString *qqNickName;
@property (nonatomic, copy) NSString *sinaNickName;

@property (nonatomic, copy) NSString *weixinOpenid;

/**
 临时昵称
 */
@property (nonatomic, copy) NSString *customNickName;


@property (nonatomic, copy) NSString *parentShareCode;
@property (nonatomic, copy) NSString *userShareCode;
@property (nonatomic, copy) NSString *cardNo;

@property (nonatomic, assign) BOOL isInReview;
@property (nonatomic, assign) BOOL hasTakenTask;

@property (nonatomic, assign) NSInteger messageCount;

@property (nonatomic, copy) NSString *currentVersion;
@property (nonatomic, assign) BOOL hasShowUpdateAlertView;

@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *zhifubao;
@property (nonatomic, assign) BOOL approved;
@end
