//
//  FZDJFriendInvitationCodeVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/11/20.
//  Copyright © 2018 FZDJ. All rights reserved.
//

#import "FZDJFriendInvitationCodeVCL.h"
#import "FZDJFriendInvitationCodeModel.h"

@interface FZDJFriendInvitationCodeVCL ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@end

@implementation FZDJFriendInvitationCodeVCL

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[FZDJFriendInvitationCodeModel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"好友分享码";
}

- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1) {
        //清空按钮
        self.textFiled.text = @"";
    } else {
        FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
        
        __weak typeof(self) weak_self = self;
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        paramDict[@"parentShareCode"] = self.textFiled.text;
         
        [self.model loadItem:paramDict success:^(NSDictionary *dict) {
            [MBProgressHUD wb_showSuccess:@"设置成功"];
            dm.userInfo.parentShareCode = self.textFiled.text;
            [dm saveData];
            
            if (weak_self.saveBlock) {
                weak_self.saveBlock();
            }
            [weak_self.navigationController popViewControllerAnimated:YES];
         } failure:^(NSError *error) {
             
         }];
    }
}


@end
