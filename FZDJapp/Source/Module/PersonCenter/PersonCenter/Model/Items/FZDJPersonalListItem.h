//
//  FZDJPersonalListItem.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FZDJPersonalListItemPosition) {
    FZDJPersonalListItemPositionTop,
    FZDJPersonalListItemPositionMid,
    FZDJPersonalListItemPositionBottom,
};

@interface FZDJPersonalListItem : NSObject

@property (nonatomic, assign) FZDJPersonalListItemPosition position;

@property (nonatomic, copy  ) NSString *bgImageName;
@property (nonatomic, copy  ) NSString *icImageName;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *descStr;

@property (nonatomic, assign) FZDJCellActionType actionType;
@property (nonatomic, assign) BOOL hiddenArrow;
@property (nonatomic, assign) BOOL hiddenLine;

@end
