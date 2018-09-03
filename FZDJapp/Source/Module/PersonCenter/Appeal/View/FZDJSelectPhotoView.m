//
//  FZDJSelectPhotoView.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/1.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJSelectPhotoView.h"
#import "FXImageView.h"

const CGFloat topMargin = 14.0f;
const CGFloat sizeWidth = 45.0f;

@interface FZDJSelectPhotoView()

@property (nonatomic, strong) UIButton *addPhotoButton;
//@property (nonatomic, strong) FXImageView *photoImageView;
//@property (nonatomic, strong) UIButton *delectButton;

@end

@implementation FZDJSelectPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAddPhotoButton];
    }
    return self;
}

- (void)createAddPhotoButton{
    self.addPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addPhotoButton.frame = CGRectMake(0, topMargin, sizeWidth, sizeWidth);
    [self.addPhotoButton setImage:[UIImage imageNamed:@"dj_task_add_btn"]
                         forState:UIControlStateNormal];
    [self.addPhotoButton addTarget:self
                            action:@selector(addPhotoButtonDidClicked)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addPhotoButton];
}

- (void)addPhotoButtonDidClicked{
    if (self.addPhotoBlcok) {
        self.addPhotoBlcok();
    }
}

- (void)setImageUrls:(NSMutableArray *)imageUrls{
    _imageUrls = imageUrls;
    
    [self refreshViewWithImageUrls];
}

- (void)refreshViewWithImageUrls{
    
    [self fx_removeAllSubviews];
    [self createAddPhotoButton];
    
    NSArray *imageUrls = self.imageUrls;
    if (imageUrls.count == 0) {
        self.addPhotoButton.left = 0;
        return;
    }
    
    CGFloat padding = 15;
    NSInteger index = 0;
    FXImageView *lastImageView = nil;
    for (NSString *url in imageUrls) {
        FXImageView *imageView = [[FXImageView alloc] init];

        imageView.left = index*sizeWidth + padding*index;
        imageView.size = CGSizeMake(sizeWidth, sizeWidth);
        imageView.top = topMargin;
        imageView.imageURL = url;
        
        [self addSubview:imageView];
        
        UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        delectBtn.left = imageView.right - 15;
        delectBtn.top = imageView.top -15;
        delectBtn.size = CGSizeMake(30, 30);
        
        [delectBtn setImage:[UIImage imageNamed:@"dj_task_close_btn"]
                   forState:UIControlStateNormal];
        delectBtn.tag = index++;
        [delectBtn addTarget:self
                      action:@selector(delectButtonDidClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:delectBtn];
        lastImageView = imageView;
    }

    self.addPhotoButton.left = lastImageView.right + padding;
}

- (void )delectButtonDidClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag;
    
//    UIView *superView = btn.superview;
//    [btn removeFromSuperview];
//    btn = nil;
//    [superView removeFromSuperview];
//    superView = nil;
    
    if (index < self.imageUrls.count) {
        [self.imageUrls removeObjectAtIndex:index];
        [self refreshViewWithImageUrls];
    }
}

@end
