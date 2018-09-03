//
//  FZDJAppealSelectPhotoStrategy.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/1.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealSelectPhotoStrategy.h"
#import "FXCaremaPhotoStrategy.h"
#import "FZDJAppealViewController.h"
#import "FZDJEditInfoVCL.h"

@interface FZDJAppealSelectPhotoStrategy()
@property (nonatomic, strong) FXCaremaPhotoStrategy *photoStrategy;
@end

@implementation FZDJAppealSelectPhotoStrategy

- (instancetype)initWithTarget:(id)target{
    
    if (self = [super initWithTarget:target]) {
        self.photoStrategy = [[FXCaremaPhotoStrategy alloc] initWithTarget:target];
    }
    
    return self;
}


- (void)presentSelectPhotoAlertView {
    UIViewController *vc = (UIViewController *)self.target;
    
    FZDJAppealViewController *businessTarget = (FZDJAppealViewController *)self.target;
//    FZDJEditInfoVCL *editInfoTarget = (FZDJEditInfoVCL *)self.target;
    
    UIAlertController * alert =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机选项
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
                                                        
        [self.photoStrategy takePhotosComplete:^(UIImage *image) {
            [businessTarget uploadImage:image];
        }];
    }];
    
    //相册选项
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.photoStrategy selectPhotoComplete:^(UIImage *image) {
            [businessTarget uploadImage:image];
        }];
    }];
    
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [vc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    
    //弹出sheet提示框
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
