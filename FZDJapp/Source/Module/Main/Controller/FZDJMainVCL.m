//
//  FZDJMainVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainVCL.h"
#import "FZDJMainCell.h"
#import "FZDJMainItem.h"
#import "FZDJMainModel.h"
#import "FZDJPersonalCenterVCL.h"
#import "FZDJMessageCenterVCL.h"
#import <SDCycleScrollView.h>
#import <SafariServices/SafariServices.h>
#import "FZDJTaskDetailVCL.h"
#import "FZDJDataModelSingleton.h"
#import "FZDJBannerDetailVCL.h"
#import "FZDJApproveVCL.h"
#import <ShareSDK/ShareSDK.h>
#import "FZDJTabBarController.h"

NSString *const FZDJMainCellIBName = @"FZDJMainCell";

@interface FZDJMainVCL ()<
SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) UIView *nodataView;

@property (nonatomic, assign) BOOL isFirstRequest;
@end

@implementation FZDJMainVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJMainModel alloc] init];
        self.isFirstRequest = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    if (dm.userInfo.userNo.length == 0) {
        //没有登录状态
        self.navigationController.navigationBar.hidden = YES;
         [self addLoginVCL];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.navigationController.navigationBar.hidden = NO;
            [self initUI];
        });
    } else {
        
        [self initUI];
        [self loadItem];
        [self realNameApprove];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

- (void)loadItem{
    [MBProgressHUD wb_showActivity];
    
    FZDJMainModel *model = (FZDJMainModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    
    [model loadBannerInfo:nil success:^(NSDictionary *dict) {
        [weak_self setBannerImageUrls];
    } failure:^(NSError *error) {
        
    }];
    
    [model loadItem:nil success:^(NSDictionary *dict) {

        if (model.items.count == 0) {
            if (!weak_self.nodataView.superview) {
                [weak_self addNodataView];
                weak_self.tableView.mj_footer.hidden = YES;
            }
            
        } else {
            if (weak_self.nodataView.superview) {
                [weak_self.nodataView removeFromSuperview];
            }
            weak_self.tableView.mj_footer.hidden = NO;
        }
        
        [weak_self endRefreshing];
        [weak_self.tableView reloadData];
        //去除iOS 审核机制
//        if (weak_self.isFirstRequest) {
//            [model loadConfigData];
//            weak_self.isFirstRequest = NO;
//        }
    } failure:^(NSError *error) {
        [weak_self endRefreshing];
    }];
    
    
    [model checkUser:nil success:^(NSDictionary *dict) {
        
    } failure:^(NSError *error) {
        [weak_self showGlobalTip:error.errorMsg];
    }];
    
}

- (void)showGlobalTip:(NSString *)errorMsg{
    
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"提示"
                                            message:errorMsg
                                     preferredStyle:UIAlertControllerStyleAlert];
    //显示弹出框
    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }]];
    
    
}

- (void)realNameApprove{
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    if (dm.userInfo.approved) {
        return;
    }
    
    __weak typeof(self) weak_self = self;
    
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"欢迎使用抖金App，为保证用户权益、账户安全，请实名认证并绑定支付宝。谢谢！" preferredStyle:UIAlertControllerStyleAlert];
    //显示弹出框
    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FZDJApproveVCL *vcl = [[FZDJApproveVCL alloc] initWithNibName:@"FZDJApproveVCL" bundle:[NSBundle mainBundle]];
        vcl.saveBlock = ^{
            [weak_self realNameApprove];
        };
        vcl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcl animated:YES];
    }]];
    
}

- (void)addNodataView{
    [self.view addSubview:self.nodataView];
}

- (void)setBannerImageUrls{
    FZDJMainModel *model = (FZDJMainModel *)self.model;
    
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:3];
    for (FZDJBannerVo *vo in model.bannerArr) {
        [muArr addObject:vo.lbimgUrl];
    }
    
    self.banner.imageURLStringsGroup = muArr;
}

- (void)addLoginVCL{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FZDJLoginVCL" bundle:nil];
    FZDJLoginVCL *loginVCL = (FZDJLoginVCL *)[storyBoard instantiateInitialViewController];
    loginVCL.delegate = self;
    [self.navigationController presentViewController:loginVCL animated:NO completion:nil];
}

- (void)setNavigationBarBackgroundImage{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_backgroud"] forBarMetrics:UIBarMetricsDefault];
}

- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = self.leftBarItem;
//    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100.0f;
    self.tableView.frame = CGRectMake(0,0,FX_SCREEN_WIDTH,FX_TABLE_HEIGHT);
    [self.tableView registerClass:[FZDJMainCell class] forCellReuseIdentifier:FZDJMainCellIBName];
    
//    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    self.tableView.tableHeaderView = self.banner;
}


- (UIBarButtonItem *)leftBarItem{
    if (!_leftBarItem) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *leftImage = [UIImage imageNamed:@"navigationitem_left"];
        [btn setImage:leftImage forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(leftBarButtonDidCliked)
                    forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(44, 44);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        btn.backgroundColor = [UIColor clearColor];
        _leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    
    return _leftBarItem;
}

- (UIBarButtonItem *)rightBarItem{
    if (!_rightBarItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *rightImage = [UIImage imageNamed:@"navigationitem_right"];
        [btn setImage:rightImage forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn addTarget:self action:@selector(rightBarButtonDidCliked)
                    forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(44, 44);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 00);
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBarItem;
}

- (void)leftBarButtonDidCliked{
    FZDJPersonalCenterVCL *personalVCL = [[FZDJPersonalCenterVCL alloc] init];

    [self.navigationController pushViewController:personalVCL animated:YES];
}

- (void)rightBarButtonDidCliked{
    FZDJMessageCenterVCL *messageVCL = [[FZDJMessageCenterVCL alloc] init];
    
    [self.navigationController pushViewController:messageVCL animated:YES];
}

#pragma mark ================ 退出登陆 ================

- (void)logout{
    //退出登录
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    [dm clearUserData];
    
    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FZDJLoginVCL" bundle:nil];
    FZDJLoginVCL *loginVCL = (FZDJLoginVCL *)[storyBoard instantiateInitialViewController];
    loginVCL.delegate = self;
    
    [self.model clean];
    [self.navigationController presentViewController:loginVCL animated:NO completion:nil];
    
}

#pragma mark ================ Lazyload ================

- (SDCycleScrollView *)banner{
    if (!_banner) {

        CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(124));
        
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];

        banner.backgroundColor = [UIColor whiteColor];
        banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        banner.currentPageDotColor = [UIColor fx_colorWithHexString:@"0B9DFF"];
        banner.pageDotColor = [UIColor whiteColor];
        
        _banner = banner;
    }
    return _banner;
}

- (UIView *)nodataView{
    if (!_nodataView) {
        UIView *nodataView = [[UIView alloc] init];
        nodataView.size = CGSizeMake(300, 300);
        nodataView.center = self.view.center;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"dj_nodata_icon"];
        imageView.size = CGSizeMake(120, 79);
        imageView.left = (300 - 120) /2;
        imageView.top = (300 - 79) / 2 - 20;
        
        [nodataView addSubview: imageView];
        
        UILabel *label = [[UILabel alloc ] initWithFrame:CGRectMake(0, imageView.bottom + 10, 300, 20)];
        label.text = @"暂无数据";
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"0xbfbfbf"];
        [nodataView addSubview:label];
        
        nodataView.userInteractionEnabled = NO;
        
        _nodataView = nodataView;
    }
    
    return _nodataView;
}

#pragma mark ================ FZDJLoginVCLDelegate ================
- (void)loginSuccess{
    // 关闭登录弹窗
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self loadItem];
    [self realNameApprove];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    FZDJMainModel *model = (FZDJMainModel *)self.model;
    
    FZDJBannerVo *vo = model.bannerArr[index];
    if ([vo.clickEvent isEqualToString:@"NB"]) {
        //内部跳转
        FZDJBannerDetailVCL *vcl = [[FZDJBannerDetailVCL alloc] init];
        vcl.titleStr = vo.lbTitle;
        vcl.htmlStr = vo.lbContent;
        vcl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcl animated:YES];
        return;
    }
    
    //外部跳转

    NSURL *url = [NSURL URLWithString:vo.lbContentUrl];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vo.lbContentUrl]];
    if (!url.scheme) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", url.absoluteString]];
    }
    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:url];
        [self.navigationController presentViewController:safariController animated:YES completion:^{
            //        safariController.view.userInteractionEnabled = YES;
        }];
    } else {
        // Fallback on earlier versions
    }


}

#pragma mark ================ UITableViewDelegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FZDJMainCell *cell = [tableView dequeueReusableCellWithIdentifier:FZDJMainCellIBName];
    FZDJMainItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJMainItem *item = self.model.items[indexPath.row];
    FZDJTaskDetailVCL *taskDetailVCL = [[FZDJTaskDetailVCL alloc] init];
    taskDetailVCL.taskNo = item.taskNo;
    taskDetailVCL.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:taskDetailVCL animated:YES];
}

@end
