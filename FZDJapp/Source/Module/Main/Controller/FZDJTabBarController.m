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

@interface FZDJTabBarController ()
@property (nonatomic, strong) FZDJMainVCL *mainVCL;
@property (nonatomic, strong) FZDJPersonalCenterVCL *personalCenterVCL;
@property (nonatomic, strong) FZDJMessageCenterVCL *messageCenterVCL;
@property (nonatomic, strong) FXMyTaskContainerVCL *myTaskVCL;

@end

@implementation FZDJTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
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
    // Do any additional setup after loading the view.
    
//    self.tabBar.backgroundColor = [UIColor redColor];
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBackgroundColor:[UIColor fx_colorWithHexString:@"#666666"]];
    [self setUpChildControllers];
    
}



- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
        selectedImage:(NSString *)selectedImage
          normalImage:(NSString *)unselectedImage{
    
    UIColor *unselectColor = [UIColor fx_colorWithHexString:@"0x333333"];
    UIColor *selectColor = [UIColor fx_colorWithHexString:@"0x1296DB"];
    
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

@end
