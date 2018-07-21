//
//  FZDJMainItem.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseItem.h"

@interface FZDJMainItem : FXBaseItem

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *timeText;
@property (nonatomic, assign) CGFloat persent;

@end
