//
//  FZDJMainVCL.m
//  FZDJapp
//
//  Created by suminjie on 2018/6/20.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJMainVCL.h"

#import "FZDJLoginVCL.h"

@interface FZDJMainVCL ()<FZDJLoginVCLDelegate>

@property (nonatomic, strong) UIBarButtonItem *leftBarItem;

@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@end

@implementation FZDJMainVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLoginVCL];
    
    [self initUI];
    
}

- (void)addLoginVCL{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FZDJLoginVCL" bundle:nil];
    FZDJLoginVCL *loginVCL = (FZDJLoginVCL *)[storyBoard instantiateInitialViewController];
    loginVCL.delegate = self;
    [self.navigationController presentViewController:loginVCL animated:NO completion:nil];
}



- (void)initUI{
    
    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
}


- (UIBarButtonItem *)leftBarItem{
    if (!_leftBarItem) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *leftImage = [UIImage imageNamed:@"navigationitem_left"];
//        [btn setBackgroundImage:leftImage forState:UIControlStateNormal];
        [btn setImage:leftImage forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(leftBarButtonDidCliked)
                  forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(44, 44);
        btn.backgroundColor = [UIColor redColor];
        _leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    
    return _leftBarItem;
}

- (UIBarButtonItem *)rightBarItem{
    if (!_rightBarItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *rightImage = [UIImage imageNamed:@"navigationitem_right"];
        [btn setImage:rightImage forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        
        [btn addTarget:self action:@selector(rightBarButtonDidCliked)
      forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(44, 44);
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBarItem;
}

- (void)leftBarButtonDidCliked{
    
}

- (void)rightBarButtonDidCliked{
    
}

- (void)closeLoginVCL{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
