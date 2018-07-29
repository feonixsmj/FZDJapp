//
//  FZDJMainVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMainVCL.h"
#import "FZDJLoginVCL.h"
#import "FZDJMainCell.h"
#import "FZDJMainItem.h"
#import "FZDJMainModel.h"
#import "FZDJPersonalCenterVCL.h"
#import "FZDJMessageCenterVCL.h"
#import <SDCycleScrollView.h>
#import <SafariServices/SafariServices.h>
#import "FZDJTaskDetailVCL.h"


NSString *const FZDJMainCellIBName = @"FZDJMainCell";

@interface FZDJMainVCL ()<

FZDJLoginVCLDelegate,
SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@property (nonatomic, strong) SDCycleScrollView *banner;
@end

@implementation FZDJMainVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJMainModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    if (NO) {
        //没有登录状态
        self.navigationController.navigationBar.hidden = YES;
         [self addLoginVCL];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.navigationController.navigationBar.hidden = NO;
            [self initUI];
        });
    } else {
        
        [self initUI];
    }
    
    [self loadItem];
}

- (void)loadItem{
    FZDJMainModel *model = (FZDJMainModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    
    [model loadBannerInfo:nil success:^(NSDictionary *dict) {
        [weak_self setBannerImageUrls];
    } failure:^(NSError *error) {
        
    }];
    
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
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
//    [self setNavigationBarBackgroundImage];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    [self.view addSubview:self.banner];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100.0f;
    self.tableView.frame = CGRectMake(0,self.banner.bottom,
                                      FX_SCREEN_WIDTH,
                                      FX_SCREEN_HEIGHT - FX_NAVIGATIONBAR_SPAGE);
    [self.tableView registerClass:[FZDJMainCell class] forCellReuseIdentifier:FZDJMainCellIBName];
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
#pragma mark ================ Lazyload ================

- (SDCycleScrollView *)banner{
    if (!_banner) {
//        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:delegate placeholderImage:placeholderImage];
//        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        
//        NSArray *imageArray = @[@"1.jpg",
//                                @"2.jpg",
//                                @"3.jpg",
//                                @"4.jpg",];
        
//        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:rect
//                                                                imageNamesGroup:imageArray];
        CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(124));
        
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];

//        banner.delegate = self;
        banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        banner.currentPageDotColor = [UIColor fx_colorWithHexString:@"0B9DFF"];
        banner.pageDotColor = [UIColor whiteColor];
        
        _banner = banner;
    }
    return _banner;
}


#pragma mark ================ FZDJLoginVCLDelegate ================
- (void)closeLoginVCL{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    FZDJMainModel *model = (FZDJMainModel *)self.model;
    NSLog(@"---点击了第%ld张图片", (long)index);
    FZDJBannerVo *vo = model.bannerArr[index];
    NSLog(@"点击链接%@",vo.lbContentUrl);
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
    [self.navigationController pushViewController:taskDetailVCL animated:YES];
}

@end
