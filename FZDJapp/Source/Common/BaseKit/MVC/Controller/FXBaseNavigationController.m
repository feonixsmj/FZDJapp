//
//  FXBaseNavigationController.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/4.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseNavigationController.h"
#import "UIViewController+BackButtonHandler.h"

@interface FXBaseNavigationController ()

@end

@implementation FXBaseNavigationController

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    UIViewController *vc = [self topViewController];
    [self popViewControllerAnimated:YES];
    [vc backButtonAction];
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setShadowImage:[UIImage new]];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [self setNavigationBarHidden:NO animated:YES];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_backgroud"] forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
