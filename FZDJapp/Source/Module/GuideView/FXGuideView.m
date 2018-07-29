//
//  FXGuideView.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXGuideView.h"

#define FXHidden_TIME   0.5

@interface FXGuideView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIPageControl *imagePageControl;
@property (nonatomic, assign) BOOL autoEnter;
@end

@implementation FXGuideView

- (instancetype)initWithFrame:(CGRect)frame
               imageNameArray:(NSArray<NSString *> *)imageNameArray
               buttonIsHidden:(BOOL)isHidden{
    
    if (self = [super initWithFrame:frame]) {
        self.imageArray = imageNameArray;
        self.autoEnter = isHidden;
        // scrollview
        UIScrollView *guidePageView = [[UIScrollView alloc]initWithFrame:frame];
        [guidePageView setBackgroundColor:[UIColor lightGrayColor]];
        [guidePageView setContentSize:CGSizeMake(FX_SCREEN_WIDTH*imageNameArray.count, FX_SCREEN_HEIGHT)];
        [guidePageView setBounces:NO];
        [guidePageView setPagingEnabled:YES];
        [guidePageView setShowsHorizontalScrollIndicator:NO];
        [guidePageView setDelegate:self];
        [self addSubview:guidePageView];
        
        // 跳过按钮
        CGRect skitButonRect = {FX_SCREEN_WIDTH*0.8, FX_SCREEN_HEIGHT*0.1, 50, 25};
        UIButton *skipButton = [[UIButton alloc] initWithFrame:skitButonRect];
        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [skipButton setBackgroundColor:[UIColor grayColor]];
        [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        skipButton.layer.cornerRadius = skipButton.height * 0.5;
        [skipButton addTarget:self
                       action:@selector(enterPage:)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:skipButton];
        
        for (NSInteger i = 0; i < imageNameArray.count; i++) {
            @autoreleasepool{
                CGRect rect = {FX_SCREEN_WIDTH*i, 0, FX_SCREEN_WIDTH, FX_SCREEN_HEIGHT};
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
                UIImage *image = [UIImage imageNamed:imageNameArray[i]];
                imageView.image = image;
                [guidePageView addSubview:imageView];
                
                
                // 设置在最后一张图片上显示进入体验按钮
                if (i == imageNameArray.count-1 && isHidden == NO) {
                    [imageView setUserInteractionEnabled:YES];
                    CGRect btnRect = {FX_SCREEN_WIDTH*0.3, FX_SCREEN_HEIGHT*0.8,
                                      FX_SCREEN_WIDTH*0.4, FX_SCREEN_HEIGHT*0.08};
                    
                    UIButton *startButton = [[UIButton alloc] initWithFrame:btnRect];
                    [startButton setTitle:@"开始体验" forState:UIControlStateNormal];
                    [startButton setTitleColor:[UIColor colorWithRed:164/255.0
                                                               green:201/255.0
                                                                blue:67/255.0
                                                               alpha:1.0] forState:UIControlStateNormal];
                    
                    [startButton.titleLabel setFont:[UIFont systemFontOfSize:21]];
                    [startButton setBackgroundImage:[UIImage imageNamed:@"guideImage_button_backgound"]
                                           forState:UIControlStateNormal];
                    [startButton addTarget:self action:@selector(enterPage:) forControlEvents:UIControlEventTouchUpInside];
                    [imageView addSubview:startButton];
                }
            }
        }
        
        // 设置引导页上的页面控制器
        self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(FX_SCREEN_WIDTH*0.0, FX_SCREEN_HEIGHT*0.9, FX_SCREEN_WIDTH*1.0, FX_SCREEN_HEIGHT*0.1)];
//        self.imagePageControl.backgroundColor = [UIColor lightGrayColor];
        self.imagePageControl.currentPage = 0;
        self.imagePageControl.numberOfPages = imageNameArray.count;
        self.imagePageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.imagePageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        [self addSubview:self.imagePageControl];
    }
    
    return self;
}
- (void)enterPage:(UIButton *)button {
    [UIView animateWithDuration:FXHidden_TIME animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(FXHidden_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelector:@selector(removeGuidePage) withObject:nil afterDelay:0.5];
        });
    }];
}

- (void)removeGuidePage {
    [self removeFromSuperview];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
    int page = scrollview.contentOffset.x / scrollview.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
    if (page == self.imageArray.count-1 && self.autoEnter == YES) {
        [self enterPage:nil];
    }
//    if (self.imageArray && page < self.imageArray.count-1 && self.autoEnter == YES) {
//        self.slideIntoNumber = 1;
//    }
//    if (self.imageArray && page == self.imageArray.count-1 && self.autoEnter == YES) {
//        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
//        if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
//            self.slideIntoNumber++;
//            if (self.slideIntoNumber == 3) {
//                [self enterPage:nil];
//            }
//        }
//    }
}
@end
