//
//  FZDJPersonalActionStrategy.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalActionStrategy.h"
#import "FZDJMyWalletVCL.h"
#import "FZDJPersonalCenterVCL.h"
#import "FZDJAboutUsVCL.h"
#import "FZDJInvitationCodeVCL.h"
#import "FXMyTaskContainerVCL.h"
#import "FZDJEditInfoVCL.h"
#import "FZDJLoginModel.h"
#import "FZDJAppealSelectPhotoStrategy.h"
#import "FZDJPersonalCenterModel.h"
#import "FZDJBankCardVCL.h"
#import "FZDJBankListVCL.h"
#import "FZDJFriendInvitationCodeVCL.h"

@interface FZDJPersonalActionStrategy ()
@property (nonatomic, strong) FZDJAppealSelectPhotoStrategy *uploadImgStrategy;
@end

@implementation FZDJPersonalActionStrategy

- (instancetype)initWithTarget:(id)target{
    if (self = [super initWithTarget:target]) {
        self.uploadImgStrategy =
            [[FZDJAppealSelectPhotoStrategy alloc] initWithTarget:target];
    }
    return self;
}

- (void)personalCellActionForwarder:(FZDJCellActionType)actionType{
    
    FZDJPersonalCenterVCL *target = (FZDJPersonalCenterVCL *)self.target;
    FZDJLoginModel *loginModel = [FZDJLoginModel new];
    
    __weak typeof(self) weak_self = self;
    
    switch (actionType) {
        case FZDJCellActionTypeWallet:{
            //钱包
            FZDJMyWalletVCL *vcl = [[FZDJMyWalletVCL alloc] init];
            vcl.hidesBottomBarWhenPushed = YES;
            [target.navigationController pushViewController:vcl animated:YES];
        }
            break;
        case FZDJCellActionTypeTask:{
            //任务
            FXMyTaskContainerVCL *task = [[FXMyTaskContainerVCL alloc] init];
            task.hidesBottomBarWhenPushed = YES;
            [target.navigationController pushViewController:task animated:YES];
        }
            break;
        case FZDJCellActionTypeInvitationCode:{
            //邀请码
            FZDJInvitationCodeVCL *vcl = [[FZDJInvitationCodeVCL alloc] init];
            vcl.hidesBottomBarWhenPushed = YES;
            [target.navigationController pushViewController:vcl animated:YES];
        }
            break;
        case FZDJCellActionTypeModifyPersonalInfo:{
            //修改个人信息
            FZDJEditInfoVCL *editVCL = [[FZDJEditInfoVCL alloc] initWithNibName:@"FZDJEditInfoVCL" bundle:[NSBundle mainBundle]];
            editVCL.hidesBottomBarWhenPushed = YES;
            [target.navigationController pushViewController:editVCL animated:YES];
        }
            break;
        case FZDJCellActionTypeModifyAvatar:{
            //修改头像
            [self.uploadImgStrategy presentSelectPhotoAlertView];
        }
            break;
        case FZDJCellActionTypeBankCard:{
            //银行卡
            FZDJBankListVCL *bankListVCL = [FZDJBankListVCL new];
//            FZDJBankCardVCL *bankCardVCL = [FZDJBankCardVCL new];
            bankListVCL.hidesBottomBarWhenPushed = YES;
            [target.navigationController pushViewController:bankListVCL animated:YES];
        }
            break;
        case FZDJCellActionTypeWeixin:{
            //微信
            [loginModel thirdLoginWithType:SSDKPlatformTypeWechat success:^(NSDictionary *dict) {
                [weak_self thirdBlind];
            } failure:^(NSError *error) {
                
            }];
        }

            break;
        case FZDJCellActionTypeQQ:{
            //qq
            [loginModel thirdLoginWithType:SSDKPlatformTypeQQ success:^(NSDictionary *dict) {
                [weak_self thirdBlind];
            } failure:^(NSError *error) {
                
            }];
        }

            break;
        case FZDJCellActionTypeWeibo:{
            //微博
            [loginModel thirdLoginWithType:SSDKPlatformTypeSinaWeibo success:^(NSDictionary *dict) {
                [weak_self thirdBlind];
            } failure:^(NSError *error) {
                
            }];
        }

            break;
        case FZDJCellActionTypeFriedShareCode:{
            //好友分享码
            
            FZDJFriendInvitationCodeVCL *vcl =
                [[FZDJFriendInvitationCodeVCL alloc]
                                initWithNibName:@"FZDJFriendInvitationCodeVCL"
                                         bundle:[NSBundle mainBundle]];
            
            vcl.saveBlock = ^{
                FZDJPersonalCenterModel *personalCenterModel = (FZDJPersonalCenterModel *)target.model;
                [personalCenterModel updateData];
            };
            [target.navigationController pushViewController:vcl animated:YES];
        }
             break;
        case FZDJCellActionTypeAboutUs:{
             //关于我们
            FZDJAboutUsVCL *vcl = [[FZDJAboutUsVCL alloc] initWithNibName:@"FZDJAboutUsVCL" bundle:[NSBundle mainBundle]];
            vcl.hidesBottomBarWhenPushed = YES;
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


- (void)thirdBlind {
    FZDJPersonalCenterVCL *target = (FZDJPersonalCenterVCL *)self.target;
    FZDJPersonalCenterModel *personalCenterModel =
                            (FZDJPersonalCenterModel *)target.model;
    
    [personalCenterModel thirdBindWithType:nil success:^(NSDictionary *dict) {
        [target reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
