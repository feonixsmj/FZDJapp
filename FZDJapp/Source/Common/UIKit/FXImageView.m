//
//  FXImageView.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FXImageView()

@end
@implementation FXImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)setImageURL:(NSString *)imageURL{
    
    UIImage *defaultImage = self.defaultImage ? [UIImage imageNamed:self.defaultImage] : nil;
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:defaultImage options:0];
    _imageURL = imageURL;
}

@end
