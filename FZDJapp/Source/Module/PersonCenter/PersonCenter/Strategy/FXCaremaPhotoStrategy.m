//
//  FXCaremaPhotoStrategy.m
//  NewsDev
//
//  Created by autoreleasepool@163.com on 2018/6/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXCaremaPhotoStrategy.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface FXCaremaPhotoStrategy()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation FXCaremaPhotoStrategy

- (instancetype)initWithTarget:(id)target{
    
    if (self = [super initWithTarget:target]) {
        
    }
    
    return self;
}

- (UIImagePickerController *)imagePicker{
    if(!_imagePicker){
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        _imagePicker = imagePicker;
    }
    return _imagePicker;
}

- (void)takePhotosComplete:(FXCaremaTakePhotosBlock)complete {
    UIViewController *vc = (UIViewController *)self.target;
    
    //选择相机时，设置UIImagePickerController对象相关属性
    self.imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    //跳转到UIImagePickerController控制器弹出相机
    [vc presentViewController:self.imagePicker animated:YES completion:nil];

}

- (void)selectPhotoComplete:(FXSelectPhotosBlock)complete {
    UIViewController *vc = (UIViewController *)self.target;
    
    //选择相册时，设置UIImagePickerController对象相关属性
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //跳转到UIImagePickerController控制器弹出相册
    [vc presentViewController:self.imagePicker animated:YES completion:nil];

}

#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera && self.takePhotosBlock) {
        self.takePhotosBlock(image);
    } else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary
              && self.selectPhotosBlock){
        self.selectPhotosBlock(image);
    }
}


@end
