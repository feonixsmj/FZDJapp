//
//  FZDJBindPhoneNumberVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJBindPhoneNumberVCL.h"

@interface FZDJBindPhoneNumberVCL ()

@end

@implementation FZDJBindPhoneNumberVCL

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定手机";
}


- (IBAction)buttonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    if (tag == 1) {
        //获取验证码
    } else {
        //立即绑定
    }
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
