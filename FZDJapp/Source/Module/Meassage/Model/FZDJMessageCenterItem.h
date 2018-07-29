//
//  FZDJMessageCenterItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJMessageCenterItem : NSObject

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL isRead;

@end
