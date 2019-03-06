//
//  FZDJApproveVCL.m
//  FZDJapp
//
//  Created by FZYG on 2019/2/1.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJApproveVCL.h"
#import "FZDJApproveModel.h"

@interface FZDJApproveVCL ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *idTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *zfbTextField;

@property (assign, nonatomic) BOOL submit;
@end

@implementation FZDJApproveVCL

- (void)dealloc
{
    if (self.saveBlock) {
        self.saveBlock();
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[FZDJApproveModel alloc] init];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"实名认证";
    self.submit = NO;
    
    [self refureshButon];
}

- (void)refureshButon{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    if (dm.userInfo.approved) {
        self.nextButton.hidden = YES;
        self.tipsLabel.hidden = YES;
        
        self.nameTextFiled.text = dm.userInfo.realName;
        self.idTextFiled.text = dm.userInfo.cardNo;
        self.zfbTextField.text = dm.userInfo.zhifubao;
        
        self.nameTextFiled.userInteractionEnabled = NO;
        self.idTextFiled.userInteractionEnabled = NO;
        self.zfbTextField.userInteractionEnabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)nextAction:(id)sender {
    [self.view endEditing:YES];
    
    if (self.nameTextFiled.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入姓名"];
        return;
    }
    
    if (self.idTextFiled.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入身份号"];
        return;
    }
    
    if (self.zfbTextField.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入支付宝账号"];
        return;
    }
    
    if (self.submit) {
        //提交
        [self submitAction];
        return;
    }
    
    self.nameTextFiled.userInteractionEnabled = NO;
    self.idTextFiled.userInteractionEnabled = NO;
    [self.nextButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submit = YES;
}

- (void)confirmSubmit{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    FZDJApproveModel *model = (FZDJApproveModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    
    NSMutableDictionary *paramDict = [NSMutableDictionary new];
    paramDict[@"userNo"] = dm.userInfo.userNo;
    paramDict[@"name"] = self.nameTextFiled.text;
    paramDict[@"cardNo"] = self.idTextFiled.text;
    paramDict[@"zfb"] = self.zfbTextField.text;
    
    [model loadItem:paramDict success:^(NSDictionary *dict) {
        dm.userInfo.approved = YES;
        [dm saveData];
        if (weak_self.saveBlock) {
            weak_self.saveBlock();
        }
        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)submitAction{
    
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功后将无法修改认证信息" preferredStyle:UIAlertControllerStyleAlert];
    //显示弹出框
    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self confirmSubmit];
    }]];
    
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
