//
//  FZDJMessageInfoVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/7.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJMessageInfoVo : NSObject

@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, copy  ) NSString *msgNo;
@property (nonatomic, copy  ) NSString *readStatus; //是否已读 是 Y 不是N
@property (nonatomic, copy  ) NSString *title;

@end
