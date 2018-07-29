//
//  FZDJEditInfoVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJEditInfoVCL.h"
#import "FXImageView.h"
#import "FZDJEditInfoModel.h"
#import "FZDJBindPhoneNumberVCL.h"
#import "FZDJEditNickNameVCL.h"

@interface FZDJEditInfoVCL ()

@property (weak, nonatomic) IBOutlet UIImageView *girlIcon;
@property (weak, nonatomic) IBOutlet UIImageView *boyIcon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet FXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@end

@implementation FZDJEditInfoVCL

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[FZDJEditInfoModel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"编辑信息";
    self.avatarImageView.layer.cornerRadius = 36 /2;
    self.avatarImageView.clipsToBounds = YES;
    
    [self refreshUI];
}

- (void)refreshUI{

    FZDJEditInfoModel *model = (FZDJEditInfoModel *)self.model;
    self.phoneNumber.text = model.phoneNumber;
    self.avatarImageView.imageURL = model.avatarImageURL;
    self.nickName.text = model.nickName;
    
    if (model.isBoy) {
        self.boyIcon.image = [UIImage imageNamed:@"dj_selected_btn"];
        self.girlIcon.image = [UIImage imageNamed:@"dj_unselcted_btn"];
    } else {
        self.boyIcon.image = [UIImage imageNamed:@"dj_unselcted_btn"];
        self.girlIcon.image = [UIImage imageNamed:@"dj_selected_btn"];
    }
}

- (IBAction)buttonDidClicked:(id)sender {
    
    FZDJEditInfoModel *model = (FZDJEditInfoModel *)self.model;
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 1:{
            //绑定手机
            FZDJBindPhoneNumberVCL *bindVCL =
                [[FZDJBindPhoneNumberVCL alloc] initWithNibName:@"FZDJBindPhoneNumberVCL"
                                                         bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:bindVCL animated:YES];
        }
            break;
        case 2:{
            //头像
        }
            break;
        case 3:{
            //修改昵称
            FZDJEditNickNameVCL *editNickNameVCL =
                [[FZDJEditNickNameVCL alloc] initWithNibName:@"FZDJEditNickNameVCL"
                                                      bundle:[NSBundle mainBundle]];
            __weak typeof(self) weak_self = self;
            FZDJEditInfoModel *model = (FZDJEditInfoModel *)self.model;
            
            editNickNameVCL.saveBlock = ^{
                [model reloadData];
                [weak_self refreshUI];
            };
            
            [self.navigationController pushViewController:editNickNameVCL animated:YES];
            
        }
            break;
        case 6:{
            //选择女
            self.boyIcon.image = [UIImage imageNamed:@"dj_unselcted_btn"];
            self.girlIcon.image = [UIImage imageNamed:@"dj_selected_btn"];
            model.isBoy = NO;
            
        }
            break;
        case 7:{
            //选择男
            self.boyIcon.image = [UIImage imageNamed:@"dj_selected_btn"];
            self.girlIcon.image = [UIImage imageNamed:@"dj_unselcted_btn"];
            model.isBoy = YES;
        }
            break;
        case 8:{
            //保存
        }
            break;
            
        default:
            break;
    }
}

@end
