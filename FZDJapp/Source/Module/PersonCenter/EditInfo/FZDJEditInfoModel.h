//
//  FZDJEditInfoModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"

@interface FZDJEditInfoModel : FXBaseModel

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *avatarImageURL;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) BOOL isBoy;

- (void)reloadData;

//修改信息
- (void)modifyPersonalInfo:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure;

@end
