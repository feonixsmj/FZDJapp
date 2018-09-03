//
//  FZDJEditNickNameVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJEditNickNameVCL.h"

@interface FZDJEditNickNameVCL ()

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextFiled;
@end

@implementation FZDJEditNickNameVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置昵称";
}

- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1) {
        //清空按钮
        self.nickNameTextFiled.text = @"";
    } else {
        //  保存操作
        FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
        dm.userInfo.nickName = self.nickNameTextFiled.text;
        
        if (self.nickNameTextFiled.text.length > 0) {
            if (self.saveBlock) {
                self.saveBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"未输入昵称");
        }

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
