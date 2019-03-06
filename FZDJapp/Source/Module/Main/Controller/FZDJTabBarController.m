//
//  FZDJTabBarController.m
//  FZDJapp
//
//  Created by FZYG on 2019/1/4.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "FZDJTabBarController.h"
#import "FZDJMainVCL.h"
#import "FZDJPersonalCenterVCL.h"
#import "FZDJMessageCenterVCL.h"
#import "FXMyTaskContainerVCL.h"
#import "FXBaseNavigationController.h"
#import "UITabBar+FXBadge.h"
#import "FZDJTabBarModel.h"
#import "FZDJCheckUpdateVo.h"

@interface FZDJTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) FZDJMainVCL *mainVCL;
@property (nonatomic, strong) FZDJPersonalCenterVCL *personalCenterVCL;
@property (nonatomic, strong) FZDJMessageCenterVCL *messageCenterVCL;
@property (nonatomic, strong) FXMyTaskContainerVCL *myTaskVCL;
@property (nonatomic, strong) FZDJTabBarModel *model;
@end

@implementation FZDJTabBarController

- (FZDJMainVCL *)getMainViewController{
    return self.mainVCL;
}

- (void)setUpChildControllers{
    self.mainVCL = [FZDJMainVCL new];
    self.personalCenterVCL = [FZDJPersonalCenterVCL new];
    self.messageCenterVCL  = [FZDJMessageCenterVCL new];
    self.myTaskVCL = [FXMyTaskContainerVCL new];
    
    [self setTabBarItem:self.mainVCL.tabBarItem
                  title:@"首页"
          selectedImage:@"fzdj_tabrbar_main"
            normalImage:@"fzdj_tabrbar_main_unselected"];
    
    [self setTabBarItem:self.myTaskVCL.tabBarItem
                  title:@"任务"
          selectedImage:@"fzdj_tabrbar_task"
            normalImage:@"fzdj_tabrbar_task_unselected"];
    
    [self setTabBarItem:self.messageCenterVCL.tabBarItem
                  title:@"消息"
          selectedImage:@"fzdj_tabrbar_message"
            normalImage:@"fzdj_tabrbar_message_unselected"];
    
    [self setTabBarItem:self.personalCenterVCL.tabBarItem
                  title:@"我的"
          selectedImage:@"fzdj_tabrbar_personal"
            normalImage:@"fzdj_tabrbar_personal_unselected"];
    
    FXBaseNavigationController *nav1 = [[FXBaseNavigationController alloc] initWithRootViewController:self.mainVCL];
    FXBaseNavigationController *nav2 = [[FXBaseNavigationController alloc] initWithRootViewController:self.myTaskVCL];
    FXBaseNavigationController *nav3 = [[FXBaseNavigationController alloc] initWithRootViewController:self.messageCenterVCL];
    FXBaseNavigationController *nav4 = [[FXBaseNavigationController alloc] initWithRootViewController:self.personalCenterVCL];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self preferredStatusBarStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.delegate = self;
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBackgroundColor:[UIColor fx_colorWithHexString:@"#666666"]];
    [self setUpChildControllers];
    
    [self requestMessageCount];
    [self checkUpdate];
}

- (void)checkUpdate {
    
    __weak typeof(self) weak_self = self;
    [self.model loadVersion:nil success:^(NSDictionary *dict) {
        [weak_self showUpdateAlertIfNeeded:dict];
    } failure:^(NSError *error) {
        
    }];
}

- (void)showUpdateAlertIfNeeded:(NSDictionary *)dict{

    FZDJCheckUpdateVo *vo = (FZDJCheckUpdateVo *)dict[@"updateVo"];
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    if ([dm.userInfo.currentVersion isEqualToString:vo.version]) {
        dm.userInfo.hasShowUpdateAlertView = NO;
    }
    
    if ([vo.needUpdate isEqualToString:@"Y"] &&
        vo.url.length > 0) {
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提示" message:vo.content preferredStyle:UIAlertControllerStyleAlert];
        //显示弹出框
        [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vo.url]];
            
            [self showUpdateAlertIfNeeded:dict];
        }]];
        
    }
    
    if (!dm.userInfo.hasShowUpdateAlertView &&
        [vo.needUpdate isEqualToString:@"N"] && vo.url.length > 0) {
        
        dm.userInfo.hasShowUpdateAlertView = YES;
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提示" message:vo.content preferredStyle:UIAlertControllerStyleAlert];
        //显示弹出框
        [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vo.url]];
            //这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    
}


- (void)requestMessageCount{
    [self loadUnreadMessage];
}

- (void)loadUnreadMessage{
    self.model = [FZDJTabBarModel new];
    __weak typeof(self) weak_self = self;
    
    [self.model loadItem:nil success:^(NSDictionary *dict) {
        NSNumber *count = dict[@"count"];
        [weak_self.tabBar showBageOnItemIndex:2 number:count.integerValue];
    } failure:^(NSError *error) {
        
    }];
}


- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
        selectedImage:(NSString *)selectedImage
          normalImage:(NSString *)unselectedImage{

//    UIColor *unselectColor = [UIColor fx_colorWithHexString:@"0x333333"];
//    UIColor *selectColor = [UIColor fx_colorWithHexString:@"0x1296DB"];
    
    tabbarItem.title = title;
    tabbarItem.image = [[UIImage imageNamed:unselectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
//    // S未选中字体颜色
//    [tabbarItem
//        setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,
//                         NSFontAttributeName:[UIFont systemFontOfSize:15]}
//     forState:UIControlStateNormal];
//
//
//    // 选中字体颜色
//    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,
//                                            NSFontAttributeName:[UIFont systemFontOfSize:15]}
//                                             forState:UIControlStateSelected];
}


//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//
//    UIViewController * rootViewController;
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        UINavigationController * navigationController = (UINavigationController*)viewController;
//        rootViewController = navigationController.visibleViewController;
//    } else {
//        rootViewController = viewController;
//    }
//
//    if ([rootViewController isEqual:self.messageCenterVCL]) {
//        [self.tabBar hideBageOnItemIndex:2];
//    }
//}

@end
