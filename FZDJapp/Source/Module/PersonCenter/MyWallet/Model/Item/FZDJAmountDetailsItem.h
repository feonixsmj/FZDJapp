//
//  FZDJAmountDetailsItem.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/11.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJAmountDetailsItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *price;

/**
  金额是否增长
 */
@property (nonatomic, assign) BOOL isIncrease;
@end
