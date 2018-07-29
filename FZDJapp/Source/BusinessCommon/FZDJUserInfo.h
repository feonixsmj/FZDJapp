//
//  FZDJUserInfo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJUserInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, assign) NSInteger sexInteger; //1 男 0女
@property (nonatomic, strong) NSNumber *phoneNumber;
@end
