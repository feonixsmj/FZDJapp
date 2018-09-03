//
//  FZDJSelectPhotoView.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/1.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZDJSelectPhotoView : UIView

@property (nonatomic, strong) NSMutableArray *imageUrls;
@property (nonatomic, copy) void(^addPhotoBlcok)(void);
@end
