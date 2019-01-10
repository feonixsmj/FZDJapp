//
//  FZDJUserInfo.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJUserInfo.h"

@implementation FZDJUserInfo

//- (NSString *)userNo{
//    return @"UN2018072009302180409584125831";
//}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.avatarURL forKey:@"avatarURL"];
    [aCoder encodeInteger:self.sexInteger forKey:@"sexInteger"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    
    [aCoder encodeObject:self.openid forKey:@"openid"];
    [aCoder encodeObject:self.userNo forKey:@"userNo"];
    [aCoder encodeInteger:self.loginType forKey:@"loginType"];
    
    [aCoder encodeObject:self.weixinNickName forKey:@"weixinNickName"];
    [aCoder encodeObject:self.qqNickName forKey:@"qqNickName"];
    [aCoder encodeObject:self.sinaNickName forKey:@"sinaNickName"];
    [aCoder encodeObject:self.customNickName forKey:@"customNickName"];
    
    [aCoder encodeObject:self.parentShareCode forKey:@"parentShareCode"];
    [aCoder encodeObject:self.userShareCode forKey:@"userShareCode"];
    [aCoder encodeObject:self.weixinOpenid forKey:@"weixinOpenid"];
    
    [aCoder encodeBool:self.isInReview forKey:@"isInReview"];
    [aCoder encodeBool:self.hasTakenTask forKey:@"hasTakenTask"];
    
    [aCoder encodeInteger:self.messageCount forKey:@"messageCount"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.avatarURL = [aDecoder decodeObjectForKey:@"avatarURL"];
        self.sexInteger = [aDecoder decodeIntegerForKey:@"sexInteger"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
        
        self.openid = [aDecoder decodeObjectForKey:@"openid"];
        self.userNo = [aDecoder decodeObjectForKey:@"userNo"];
        self.loginType = [aDecoder decodeIntegerForKey:@"loginType"];
        
        self.weixinNickName = [aDecoder decodeObjectForKey:@"weixinNickName"];
        self.qqNickName = [aDecoder decodeObjectForKey:@"qqNickName"];
        self.sinaNickName = [aDecoder decodeObjectForKey:@"sinaNickName"];
        self.customNickName = [aDecoder decodeObjectForKey:@"customNickName"];
        
        self.parentShareCode = [aDecoder decodeObjectForKey:@"parentShareCode"];
        self.userShareCode = [aDecoder decodeObjectForKey:@"userShareCode"];
        self.cardNo = [aDecoder decodeObjectForKey:@"cardNo"];
        self.weixinOpenid = [aDecoder decodeObjectForKey:@"weixinOpenid"];
        
        self.isInReview = [aDecoder decodeBoolForKey:@"isInReview"];
        self.hasTakenTask = [aDecoder decodeBoolForKey:@"hasTakenTask"];
        
        self.messageCount = [aDecoder decodeIntegerForKey:@"messageCount"];
    }
    return self;
}

@end
