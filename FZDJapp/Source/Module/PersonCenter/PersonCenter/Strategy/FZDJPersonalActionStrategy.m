//
//  FZDJPersonalActionStrategy.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalActionStrategy.h"
#import "FZDJMyWalletVCL.h"
#import "FZDJPersonalCenterVCL.h"
#import "FZDJAboutUsVCL.h"
#import "FZDJInvitationCodeVCL.h"

@implementation FZDJPersonalActionStrategy

- (void)personalCellActionForwarder:(FZDJCellActionType)actionType{
    
    FZDJPersonalCenterVCL *target = (FZDJPersonalCenterVCL *)self.target;
    
    switch (actionType) {
        case FZDJCellActionTypeWallet:{
            //钱包
            NSLog(@"打开钱包");
            FZDJMyWalletVCL *vcl = [[FZDJMyWalletVCL alloc] init];
            [target.navigationController pushViewController:vcl animated:YES];
        }
            break;
        case FZDJCellActionTypeTask:
            //任务
            NSLog(@"打开任务");
            break;
        case FZDJCellActionTypeInvitationCode:{
            //邀请码
            FZDJInvitationCodeVCL *vcl = [[FZDJInvitationCodeVCL alloc] init];
            [target.navigationController pushViewController:vcl animated:YES];
        }
            break;
        case FZDJCellActionTypeModifyPersonalInfo:
            //修改个人信息
            NSLog(@"修改个人信息");
            break;
        case FZDJCellActionTypeModifyAvatar:
            //修改头像
            NSLog(@"修改头像");
            break;
        case FZDJCellActionTypeRealNameVerify:
            //实名认证
            NSLog(@"实名认证");
            break;
        case FZDJCellActionTypeBankCard:
            //银行卡
            NSLog(@"银行卡");
            break;
        case FZDJCellActionTypeWeixin:
            //微信
            NSLog(@"微信");
            break;
        case FZDJCellActionTypeQQ:
            //QQ
            NSLog(@"QQ");
            break;
        case FZDJCellActionTypeWeibo:
            //微博
            NSLog(@"微博");
            break;
        case FZDJCellActionTypeFriedShareCode:
            //好友分享码
            NSLog(@"好友分享码");
            break;
        case FZDJCellActionTypeAboutUs:{
             //关于我们
            FZDJAboutUsVCL *vcl = [[FZDJAboutUsVCL alloc] initWithNibName:@"FZDJAboutUsVCL" bundle:[NSBundle mainBundle]];
            [target.navigationController pushViewController:vcl animated:YES];
        }
            break;
        case FZDJCellActionTypeContactUs:
            //联系客服
            NSLog(@"联系客服");
            break;
            
        default:
            break;
    }
}


@end
