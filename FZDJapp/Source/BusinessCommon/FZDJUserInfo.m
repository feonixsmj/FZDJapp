//
//  FZDJUserInfo.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJUserInfo.h"

@implementation FZDJUserInfo
//@property (nonatomic, copy) NSString *nickName;
//@property (nonatomic, copy) NSString *avatarURL;
//@property (nonatomic, assign) NSInteger sexInteger; //1 男 9女
//@property (nonatomic, strong) NSNumber *phoneNumber;

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.avatarURL forKey:@"avatarURL"];
    [aCoder encodeInteger:self.sexInteger forKey:@"sexInteger"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.avatarURL = [aDecoder decodeObjectForKey:@"avatarURL"];
        self.sexInteger = [aDecoder decodeIntegerForKey:@"sexInteger"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
    }
    return self;
}

@end
