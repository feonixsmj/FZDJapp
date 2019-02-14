//
//  FZDJPersonalCenterModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalCenterModel.h"
#import "FZDJMainRequest.h"
#import "FZDJPersonalInfoVo.h"
#import "FXSystemInfo.h"
#import "NSString+FXCategory.h"
#import "FZDJCheckUpdateVo.h"


@interface FZDJPersonalCenterModel()

@property (nonatomic, strong) FZDJMainRequest *request;
@property (nonatomic, copy) NSString *serverEmail;
@end

@implementation FZDJPersonalCenterModel

- (void)updateData{
    [self wrapperItems:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
        self.serverEmail = @"";
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [self wrapperItems:nil];
    success(nil);
    
    __weak typeof(self) weak_self = self;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskUserGet];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            FZDJPersonalInfoVo *info = [FZDJPersonalInfoVo
                                        mj_objectWithKeyValues:responseObject[@"body"]];
            [weak_self wrapperItems:info];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


- (void)updateUserInfo:(FZDJPersonalInfoVo *)vo{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    FZDJUserInfo *userinfo = dm.userInfo;
    userinfo.avatarURL = vo.headImg;
    
    userinfo.weixinNickName = vo.wxNickName;
    userinfo.qqNickName = vo.qqNickName;
    userinfo.sinaNickName = vo.wbNickName;
    userinfo.nickName = vo.nickName;
    userinfo.zhifubao = vo.zfb; //支付宝账号
    userinfo.realName = vo.name; //真实姓名
//    userinfo.approved = NO;
    userinfo.approved = [vo.auth isEqualToString:@"Y"]; //是否实名认证
    
    userinfo.sexInteger = [vo.sex isEqualToString:@"NAN"] ? 1 : 0;
    userinfo.phoneNumber = vo.phone;
    userinfo.cardNo = vo.cardNo; //身份证号
    userinfo.userShareCode = vo.userShareCode;
    userinfo.parentShareCode = vo.parentShareCode;
    
    [dm saveData];
}

- (void)wrapperItems:(FZDJPersonalInfoVo *)vo{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    if (vo) {
        [self updateUserInfo:vo];
    }
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    FZDJPersonalInfoItem *infoItem = [FZDJPersonalInfoItem new];
    infoItem.avatarUrl = dm.userInfo.avatarURL;
    infoItem.isGirl = dm.userInfo.sexInteger == 0;
    infoItem.nickName = dm.userInfo.nickName;
    [muArr addObject:infoItem];
    
    FZDJPersonalTaskItem *taskItem = [FZDJPersonalTaskItem new];
    [muArr addObject:taskItem];
    
    NSArray *listArr = [self getListItemArray];
    [muArr addObjectsFromArray:listArr];
    
    self.items = muArr;
}

- (NSArray *)getListItemArray{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    FZDJPersonalListItem *bankItem = [FZDJPersonalListItem new];
    bankItem.icImageName = @"dj_yhka_icon";
    bankItem.bgImageName = @"dj_card_top";
    bankItem.title = @"银行卡";
    bankItem.actionType = FZDJCellActionTypeBankCard;
    
    FZDJPersonalListItem *weixinItem = [FZDJPersonalListItem new];
    weixinItem.icImageName = @"dj_weixin_icon";
    weixinItem.title = @"微信";
    if (dm.userInfo.weixinNickName.length > 0) {
        weixinItem.descStr = dm.userInfo.weixinNickName;
        weixinItem.hiddenArrow = YES;
    } else {
        weixinItem.descStr = @"去绑定";
        weixinItem.hiddenArrow = NO;
    }
    weixinItem.actionType = FZDJCellActionTypeWeixin;
    
    FZDJPersonalListItem *zhifubaoItem = [FZDJPersonalListItem new];
    zhifubaoItem.icImageName = @"dj_zhifubao_icon";
    zhifubaoItem.title = @"支付宝";
    zhifubaoItem.descStr = dm.userInfo.zhifubao;
    zhifubaoItem.hiddenArrow = NO;
    zhifubaoItem.actionType = FZDJCellActionTypeZhifubao;
    
    FZDJPersonalListItem *approveItem = [FZDJPersonalListItem new];
    approveItem.icImageName = @"dj_approve_bg";
    approveItem.bgImageName = @"dj_card_bottom";
    approveItem.title = @"实名认证";
    approveItem.descStr = dm.userInfo.approved ? @"已认证" : @"去认证";
    approveItem.hiddenArrow = NO;
    approveItem.actionType = FZDJCellActionTypeApproved;
    
//    FZDJPersonalListItem *qqItem = [FZDJPersonalListItem new];
//    qqItem.icImageName = @"dj_qq_icon";
//    qqItem.title = @"QQ";
//    if (dm.userInfo.qqNickName.length > 0) {
//        qqItem.descStr = dm.userInfo.qqNickName;
//        qqItem.hiddenArrow = YES;
//    } else {
//        qqItem.descStr = @"去绑定";
//        qqItem.hiddenArrow = NO;
//    }
//    qqItem.actionType = FZDJCellActionTypeQQ;
    
//    FZDJPersonalListItem *weiboItem = [FZDJPersonalListItem new];
//    weiboItem.icImageName = @"dj_weibo_icon";
//    weiboItem.bgImageName = @"dj_card_bottom";
//    weiboItem.title = @"微博";
//    if (dm.userInfo.sinaNickName.length > 0) {
//        weiboItem.descStr = dm.userInfo.sinaNickName;
//        weiboItem.hiddenArrow = YES;
//    } else {
//        weiboItem.descStr = @"去绑定";
//        weiboItem.hiddenArrow = NO;
//    }
//    weiboItem.actionType = FZDJCellActionTypeWeibo;
    
    FZDJPersonalListItem *shareItem = [FZDJPersonalListItem new];
    shareItem.icImageName = @"dj_share_icon";
    shareItem.bgImageName = @"dj_card_top";
    shareItem.title = @"好友分享码";
    shareItem.descStr = dm.userInfo.parentShareCode;
    shareItem.hiddenArrow = shareItem.descStr.length > 0 ? YES:NO;
    shareItem.actionType = FZDJCellActionTypeFriedShareCode;
    
    FZDJPersonalListItem *aboutUsItem = [FZDJPersonalListItem new];
    aboutUsItem.icImageName = @"dj_us_icon";
    aboutUsItem.bgImageName = dm.userInfo.isInReview ? @"dj_card_top" : @"dj_card_mid";
    aboutUsItem.title = @"关于我们";
    aboutUsItem.actionType = FZDJCellActionTypeAboutUs;
    
    FZDJPersonalListItem *checkItem = [FZDJPersonalListItem new];
    checkItem.icImageName = @"dj_check_update_icon";
    checkItem.bgImageName = @"dj_card_mid";
    checkItem.title = @"检查更新";
    checkItem.descStr = [NSString stringWithFormat:@"当前版本:%@",dm.userInfo.currentVersion];
    checkItem.actionType = FZDJCellActionTypeCheckUpdate;
    
    
    FZDJPersonalListItem *serverItem = [FZDJPersonalListItem new];
    serverItem.icImageName = @"dj_kefu_icon";
    serverItem.bgImageName = @"dj_card_bottom";
    serverItem.title = @"联系客服";
    serverItem.hiddenArrow = YES;
    serverItem.descStr = self.serverEmail;
    serverItem.actionType = FZDJCellActionTypeContactUs;
    
    FZDJPersonalBlankItem *blankItem = [FZDJPersonalBlankItem new];

    NSArray *listArr = @[bankItem,
                         weixinItem,
//                         qqItem,
//                         weiboItem,
                         zhifubaoItem,
                         approveItem,
                         
                         blankItem,
                         shareItem,
                         aboutUsItem,
                         checkItem,
                         serverItem,
                         blankItem
                         ];
    
    if (dm.userInfo.isInReview) {
       listArr =  @[bankItem,
                  weixinItem,
//                  qqItem,
//                  weiboItem,
                    zhifubaoItem,
                    approveItem,
                    
                  blankItem,
                  
                  aboutUsItem,
                    checkItem,
                  serverItem,
                  blankItem
                  ];
    }
    return listArr;
}

- (void)loadCustomServer:(NSDictionary *)parameterDict
                 success:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure{
    __weak typeof(self) weak_self = self;

    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiLXKF];
    
    [self.request requestPostURL:url parameters:nil success:^(id responseObject) {
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *resDict = responseObject;
            weak_self.serverEmail = resDict[@"body"];
            
            if (weak_self.items.count > 0) {
                [weak_self updateContactUs];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)updateContactUs{
    
    for (NSObject *obj in self.items) {
        if ([obj isKindOfClass:[FZDJPersonalListItem class]]) {
            FZDJPersonalListItem *item = (FZDJPersonalListItem *)obj;
            if (item.actionType == FZDJCellActionTypeContactUs) {
                item.descStr = self.serverEmail;
                break;
            }
        }
    }
}

- (void)thirdBindWithType:(NSDictionary *)parameterDict
                  success:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(NSError *error))failure {
    
//    __weak typeof(self) weak_self = self;
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"headImg"] = dm.userInfo.avatarURL;
    parameter[@"ip"] = [NSString getIPAddress:NO];
    
    parameter[@"machineCode"] = [FXSystemInfo orginalIdfa];
    parameter[@"nickName"] = dm.userInfo.customNickName;
    parameter[@"sex"] = dm.userInfo.sexInteger == 1 ? @"NAN":@"NV";
    parameter[@"userNo"] = dm.userInfo.userNo;
    parameter[@"openid"] = dm.userInfo.openid;
    
    NSString *loginType = @"";
    if (dm.userInfo.loginType == FZDJUserInfoLoginTypeQQ) {
        loginType = @"QQ";
    } else if (dm.userInfo.loginType == FZDJUserInfoLoginTypeWechat){
        loginType = @"WX";
    } else if (dm.userInfo.loginType == FZDJUserInfoLoginTypeWeibo){
        loginType = @"WB";
    }
    parameter[@"type"] = loginType;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUserBinding];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        if ([responseObject[@"head"][@"respCode"] integerValue] == 0) {
            success(nil);
        } else {
            failure(nil);
            NSLog(@"绑定失败");
        }
    } failure:^(NSError *error) {
        failure(error);
        NSLog(@"绑定失败");
    }];
}

- (void)loadVersion:(NSDictionary *)parameterDict
            success:(void (^)(NSDictionary *dict))success
            failure:(void (^)(NSError *error))failure{
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiCheckUpdate];
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc] init];
    mudict[@"version"] = dm.userInfo.currentVersion;
    
    [self.request requestPostURL:url parameters:mudict success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
    
        FZDJCheckUpdateVo *updateVo = [FZDJCheckUpdateVo mj_objectWithKeyValues:dict[@"body"]];
        
        if (updateVo) {
            success(@{@"updateVo":updateVo});
        } else {
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
