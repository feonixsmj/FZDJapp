//
//  FZDJMessageCenterModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJMessageCenterItem.h"

@interface FZDJMessageCenterModel : FXBaseModel

- (void)setMsgRead:(FZDJMessageCenterItem *)item
           success:(void (^)(FZDJMessageCenterItem *))success
           failure:(void (^)(NSError *))failure;

- (void)readAllSuccess:(void (^)(void))success
               failure:(void (^)(NSError *))failure;

@end
