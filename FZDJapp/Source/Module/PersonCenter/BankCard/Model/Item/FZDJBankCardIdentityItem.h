//
//  FZDJBankCardIdentityItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FZDJBankCardIdentityItemType) {
    FZDJBankCardIdentityItemTypeName,//持卡人姓名
    FZDJBankCardIdentityItemTypeID,//身份证
    FZDJBankCardIdentityItemTypePhoneNumber,//手机号
    FZDJBankCardIdentityItemTypeCardNumber//银行卡号
};

@interface FZDJBankCardIdentityItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) FZDJBankCardIdentityItemType type;
@end
