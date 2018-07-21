//
//  FXCaremaPhotoStrategy.h
//  NewsDev
//
//  Created by autoreleasepool@163.com on 2018/6/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseStrategy.h"

typedef void(^FXCaremaTakePhotosBlock) (UIImage *image);
typedef void(^FXSelectPhotosBlock) (UIImage *image);

@interface FXCaremaPhotoStrategy : FXBaseStrategy

/** 拍照回调*/
@property (nonatomic, copy) FXCaremaTakePhotosBlock takePhotosBlock;
/** 选择相册回调*/
@property (nonatomic, copy) FXSelectPhotosBlock selectPhotosBlock;

/**
 * 拍照
 */
- (void)takePhotosComplete:(FXCaremaTakePhotosBlock)complete;

/**
 * 选择相册
 */
- (void)selectPhotoComplete:(FXSelectPhotosBlock)complete;

@end
