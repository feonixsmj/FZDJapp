//
//  FZDJInvitationCodeModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/18.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJInvitationCodeItem.h"

@interface FZDJInvitationCodeModel : FXBaseModel

@property (nonatomic, copy) NSString *htmlStr;

- (void)loadDesc:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure;
@end
