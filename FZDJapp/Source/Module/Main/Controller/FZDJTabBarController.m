//
//  FZDJTabBarController.m
//  FZDJapp
//
//  Created by smj on 2019/1/4.
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBackgroundColor:[UIColor fx_colorWithHexString:@"#666666"]];
    [self setUpChildControllers];
    
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


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    UIViewController * rootViewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * navigationController = (UINavigationController*)viewController;
        rootViewController = navigationController.visibleViewController;
    } else {
        rootViewController = viewController;
    }
    
    if ([rootViewController isEqual:self.messageCenterVCL]) {
        [self.tabBar hideBageOnItemIndex:2];
    }
}

@end
