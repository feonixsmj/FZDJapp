//
//  FZDJUploadImageModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/6.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"

@interface FZDJUploadImageModel : FXBaseModel

//上传图片
- (void)uploadImage:(UIImage *)image
            success:(void (^)(NSDictionary *))success
            failure:(void (^)(NSError *))failure;
@end
