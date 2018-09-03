//
//  FZDJEditInfoVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJEditInfoVCL.h"
#import "FXImageView.h"
#import "FZDJEditInfoModel.h"
#import "FZDJBindPhoneNumberVCL.h"
#import "FZDJEditNickNameVCL.h"
#import "FZDJAppealSelectPhotoStrategy.h"
#import "FZDJUploadImageModel.h"

@interface FZDJEditInfoVCL ()

@property (weak, nonatomic) IBOutlet UIImageView *girlIcon;
@property (weak, nonatomic) IBOutlet UIImageView *boyIcon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet FXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (nonatomic, strong) FZDJAppealSelectPhotoStrategy *strategy;
@property (nonatomic, strong) FZDJUploadImageModel *uploadImageModel;
@end

@implementation FZDJEditInfoVCL

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[FZDJEditInfoModel alloc] init];
        self.strategy = [[FZDJAppealSelectPhotoStrategy alloc] initWithTarget:self];
        self.uploadImageModel = [[FZDJUploadImageModel alloc] init];
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

- (void)uploadImage:(UIImage *)image{
    
    self.avatarImageView.image = image;
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    [self.uploadImageModel uploadImage:image success:^(NSDictionary *dict) {
        NSString *url = dict[@"url"];
        if (url.length > 0) {
            dm.userInfo.avatarURL = url;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)buttonDidClicked:(id)sender {
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
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
            [self.strategy presentSelectPhotoAlertView];
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
            dm.userInfo.sexInteger = 0;
            
        }
            break;
        case 7:{
            //选择男
            self.boyIcon.image = [UIImage imageNamed:@"dj_selected_btn"];
            self.girlIcon.image = [UIImage imageNamed:@"dj_unselcted_btn"];
            model.isBoy = YES;
            dm.userInfo.sexInteger = 1;
        }
            break;
        case 8:{
            //保存
            __weak typeof(self) weak_self = self;
            [model modifyPersonalInfo:nil success:^(NSDictionary *dict) {
                NSLog(@"保存成功");
                [weak_self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                NSLog(@"保存失败");
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
