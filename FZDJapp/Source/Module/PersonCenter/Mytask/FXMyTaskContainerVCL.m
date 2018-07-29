//
//  FXMyTaskContainerVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXMyTaskContainerVCL.h"
#import "FXMyTaskViewController.h"

CGFloat topBarHeight = 50.0f;

@interface FXMyTaskContainerVCL ()

@end

@implementation FXMyTaskContainerVCL

- (instancetype)init
{
    if (self = [super initWithTagViewHeight:topBarHeight]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的任务";
    
    [self setupTopBar];
}

- (void)setupTopBar{
    
    self.tagItemSize = CGSizeMake(FX_SCREEN_WIDTH/2, topBarHeight);
    //    self.selectedIndicatorSize = CGSizeMake(30, 8);
    self.normalTitleFont = [UIFont systemFontOfSize:16];
    self.normalTitleColor = [UIColor fx_colorWithHexString:@"333333"];
    self.selectedTitleColor = [UIColor fx_colorWithHexString:@"#2B8EFF"];
    self.selectedIndicatorColor = self.selectedTitleColor;
    self.selectedTitleFont = [UIFont systemFontOfSize:16];
    
    self.graceTime = 15;
    self.gapAnimated = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[@"已完成",@"未完成"];
    NSArray *className = @[[FXMyTaskViewController class],
                           [FXMyTaskViewController class]];
    NSArray *params = @[FXTaskCompleted,FXTaskNoCompleted];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:className withParams:params];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
