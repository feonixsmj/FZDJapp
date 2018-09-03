//
//  FZDJUploadImageModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/6.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJUploadImageModel.h"
#import "FZDJMainRequest.h"

@interface FZDJUploadImageModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJUploadImageModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [FZDJMainRequest new];
    }
    return self;
}

#pragma mark - ================ 上传图片 ================

- (void)uploadImage:(UIImage *)image
            success:(void (^)(NSDictionary *))success
            failure:(void (^)(NSError *))failure{
    NSString *urlstr =
    [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskUpLoadBase64Image];
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.8f);
    NSString *base64ImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    base64ImageStr = [base64ImageStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"base64Data=%@&fileType=jpg",base64ImageStr];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            id body = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dict = (NSDictionary *)body;
            success(dict);
        });
        
    }];
    
    [task resume];
}

@end
