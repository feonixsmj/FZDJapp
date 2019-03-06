//
//  FZDJEditZhifubaoVCL.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/23.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJEditZhifubaoVCL.h"
#import "FZDJEditZhifubaoModel.h"
@interface FZDJEditZhifubaoVCL ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@end

@implementation FZDJEditZhifubaoVCL

- (void)dealloc
{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置支付宝";
    
    self.model = [FZDJEditZhifubaoModel new];
}


- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1) {
        //清空按钮
        self.textFiled.text = @"";
    } else {
        //  保存操作
        FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
        dm.userInfo.nickName = self.textFiled.text;
        
        if (self.textFiled.text.length > 0) {
            __weak typeof(self) weak_self = self;
            
            FZDJEditZhifubaoModel *model = (FZDJEditZhifubaoModel *)self.model;
            FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
            
            NSDictionary *paramDict = @{@"zfb":self.textFiled.text,
                                        @"userNo":dm.userInfo.userNo
                                        };
            
            [model loadItem:paramDict success:^(NSDictionary *dict) {
                dm.userInfo.zhifubao = weak_self.textFiled.text;
                if (!weak_self.keepAlive) {
                    [weak_self.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSError *error) {
                
            }];
            
            
        } else {
            [MBProgressHUD wb_showError:@"请输入支付宝账号"];
        }
        
    }
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
