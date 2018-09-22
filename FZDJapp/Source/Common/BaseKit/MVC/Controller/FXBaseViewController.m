//
//  FXBaseViewController.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseViewController.h"

@interface FXBaseViewController ()

@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation FXBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FXBaseModel alloc] init];
        self.hiddenNavigationBar = NO;
        self.isTransparentBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
            @{NSFontAttributeName:[UIFont systemFontOfSize:19],
              NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    [self addNoNavigationBarCloseBtn];
}

- (void)addNoNavigationBarCloseBtn{
    
    if (self.hiddenNavigationBar) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 10, 44, 44);

        [button setImage:[UIImage imageNamed:@"navigation_close_btn"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(closePage)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        self.closeBtn = button;
    }

}

- (void)closePage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bringCloseButtonToFront{
    [self.view bringSubviewToFront:self.closeBtn];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //控制是否显示导航栏
    if (self.hiddenNavigationBar){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    
    UIImage *image = self.isTransparentBar ? [UIImage new] :
                    [UIImage imageNamed:@"navigation_backgroud"];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews{
    
}

- (void)loadItem{
    
}

//#pragma mark ================ tableDelegate ================

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 20;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
@end
