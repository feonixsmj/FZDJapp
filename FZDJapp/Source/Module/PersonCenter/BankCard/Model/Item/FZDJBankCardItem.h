//
//  FZDJBankCardItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FZDJBankCardItemType){
    FZDJBankCardItemTypeProvince =1,//省市
    FZDJBankCardItemTypeOrgBankName, //开户行总行名称
    FZDJBankCardItemTypeBankAddress  //开户行地址
};

@interface FZDJBankCardItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contentText;

@property (nonatomic, assign) FZDJBankCardItemType type;
@end
