//
//  FZDJTaskDetailVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/29.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJTaskDetailVCL.h"
#import "FZDJTaskDetailModel.h"
#import "FXImageView.h"
#import "FZDJTaskDetaiInfoView.h"
#import "FXSystemInfo.h"
#import <SafariServices/SafariServices.h>

const CGFloat FXHeaderImageViewHeight = 194;

@interface FZDJTaskDetailVCL ()

//@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *htmlLabel;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) FXImageView *headerImageView;
@property (nonatomic, strong) FZDJTaskDetaiInfoView *detailInfoView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIButton *statusButton;
@end

@implementation FZDJTaskDetailVCL

- (void)setTaskNo:(NSString *)taskNo{
    _taskNo = taskNo;
    
    [self loadItem];
}

- (void)setTaskInstNo:(NSString *)taskInstNo{
    _taskInstNo = taskInstNo;
    
    [self loadItem];
    if (taskInstNo.length > 0) {
        self.statusButton.hidden = YES;
        self.bottomView.hidden = YES;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJTaskDetailModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"任务详情";
    [self createWebView];
}

- (void)loadItem{
    __weak typeof(self) weak_self = self;
    FZDJTaskDetailModel *model = (FZDJTaskDetailModel *)self.model;
    
    if (self.taskInstNo.length > 0) {
        NSDictionary *parameterDict = @{
                                        @"taskInstNo":self.taskInstNo
                                        };
        [model requestMyTask:parameterDict success:^(NSDictionary *dict) {
            [weak_self refreshView];
        } failure:^(NSError *error) {
            
        }];
    } else {
        NSDictionary *parameterDict = @{
                                        @"taskNo":self.taskNo.length > 0 ? self.taskNo:@""
                                        };
        [model loadItem:parameterDict success:^(NSDictionary *dict) {
            [weak_self refreshView];
        } failure:^(NSError *error) {
            
        }];
    }

}


#pragma mark - ================ 领取任务 ================

- (void)getTask{
    __weak typeof(self) weak_self = self;
    FZDJTaskDetailModel *model = (FZDJTaskDetailModel *)self.model;
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    [model getTask:nil success:^(NSDictionary *dict) {
        [weak_self doTaskURL:model.item.taskUrl];
        [weak_self refreshStatusButton:FZDJTaskDetailItemStatusTaken];
    } failure:^(NSError *error) {

    }];
    
}

- (void)doTaskURL:(NSString *)taskUrl{
    
    NSURL *url = [NSURL URLWithString:taskUrl];
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

#pragma mark - ================ 刷新方法 ================
- (void)refreshView {
    FZDJTaskDetailModel *model = (FZDJTaskDetailModel *)self.model;
    
    self.headerImageView.imageURL = model.item.imageURL;
    self.detailInfoView.item = model.item;
//    [self.webView loadHTMLString:model.item.taskContent baseURL:nil];
    
    NSString *htmlStr = model.item.taskContent;
    htmlStr =  @"<p><strong>任务目标：升级城堡到11级</strong></p><p><strong>任务奖励</strong>：<br/></p><p>1，完成任务自动获得奖励（立返)</p><p>2，如果未获得奖励，点击申诉按钮提交对应截图给客服申诉</p><p><strong>注意事项</strong>：<br/></p><p>1，苹果仅限WIFI下载，安卓4G和WIFI均可</p><p>2，领取任务后请立即下载游戏，下载过程中不得中断或者更换网络</p><p>3，任务期间不得卸载游戏或者更换ID</p><p><strong>任务流程</strong>：<br/></p><p>1，加入联盟可获得200水晶，花费500水晶可购买VIP5</p><p>2，城堡4级之后，左侧会出现13D任务，尽量完成，有助于加快完成速度</p><p>3，购买礼包可大大加快升级速度，建议购买6元和30元得【赢在起跑点】礼包</p>";
    
    NSData *htmlData = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attrStr =
        [[NSAttributedString alloc] initWithData:htmlData
            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                          documentAttributes:nil error:nil];
    
    self.htmlLabel.attributedText = attrStr;
    
    [self refreshStatusButton:model.item.status];
}

- (void)refreshStatusButton:(FZDJTaskDetailItemStatus)status{
    NSString *imageName = @"dj_task_detail_normal_btn";
    switch (status) {
        case FZDJTaskDetailItemStatusNormal:{
            //去领取
            imageName = @"dj_task_detail_normal_btn";
            self.statusButton.enabled = YES;
        }
            break;
        case FZDJTaskDetailItemStatusTimeOut:{
            //已结束 不可点击
            imageName = @"dj_taskdetail_timeout";
            self.statusButton.enabled = NO;
        }
            break;
        case FZDJTaskDetailItemStatusGetFinished:{
            //已领完 不可点击
            imageName = @"dj_taskdetail_timeout";
            self.statusButton.enabled = NO;
        }
            break;
        case FZDJTaskDetailItemStatusTaken:{
            //已领取 不可点击
            imageName = @"dj_task_detail_lingqu_btn";
            self.statusButton.enabled = NO;
        }
            break;
            
        default:
            break;
    }
    
    [self.statusButton setImage:[UIImage imageNamed:imageName]
                       forState:UIControlStateNormal];
}

#pragma mark - ================ 创建UI ================

- (void)createWebView{
    CGFloat height = self.statusButton.hidden ? FX_TABLE_HEIGHT : FX_TABLE_HEIGHT-50;
    CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, height);
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    
//    NSURL *url = [NSURL URLWithString:[@"http://www.baidu.com" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    [webView.scrollView addSubview:self.headerView];
//    self.webView = webView;
//    [self.view addSubview:webView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.alwaysBounceVertical = YES;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    [scrollView addSubview:self.headerView];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    self.htmlLabel = [[UILabel alloc] init];
    self.htmlLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.htmlLabel];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.statusButton];
    
    [self layoutView];
}

- (void)layoutView{
    [self.htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.scrollView.mas_left).offset(20);
        make.width.mas_equalTo(self.scrollView.width - 40);
        make.bottom.mas_equalTo(self.scrollView);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-FX_BOTTOM_SPAGE);
        make.height.mas_equalTo(50);
    }];
    
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView).insets(UIEdgeInsetsMake(7, 10, 7, 10));
    }];
    
}

#pragma mark - ================ Lazzy Load ================

- (UIView *)headerView{
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        headerView.backgroundColor = [UIColor whiteColor];
        
        [headerView addSubview:self.headerImageView];
        [headerView addSubview:self.detailInfoView];

        [self.detailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImageView.mas_bottom);
            make.left.right.equalTo(headerView);
            make.height.mas_equalTo(115);
        }];
        
        headerView.width = FX_SCREEN_WIDTH;
        headerView.height = self.headerImageView.height +
                            [FZDJTaskDetaiInfoView viewHeight];
        
        _headerView = headerView;
    }
    return _headerView;
}

- (FXImageView *)headerImageView{
    if (!_headerImageView) {
        
        FXImageView *imageView =
            [[FXImageView alloc] initWithFrame:CGRectMake(0,0,
                        FX_SCREEN_WIDTH,FX_SCALE_ZOOM(FXHeaderImageViewHeight))];
        _headerImageView = imageView;
    }
    return _headerImageView;
}

- (FZDJTaskDetaiInfoView *)detailInfoView{
    if (!_detailInfoView) {
        
        FZDJTaskDetaiInfoView *infoView =
                [[NSBundle mainBundle] loadNibNamed:@"FZDJTaskDetaiInfoView"
                                              owner:self options:nil].lastObject;
    
        _detailInfoView = infoView;
    }
    return _detailInfoView;
}

- (UIImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] initWithImage:
                            [UIImage imageNamed:@"dj_task_detail_bg"]];
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}

- (UIButton *)statusButton{
    if (!_statusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"dj_task_detail_normal_btn"]
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonAction)
         forControlEvents:UIControlEventTouchUpInside];
        button.enabled = NO;
        _statusButton = button;
    }
    return _statusButton;
}

- (void)buttonAction{
    FZDJTaskDetailModel *model = (FZDJTaskDetailModel *)self.model;
    
    if (model.item.status == FZDJTaskDetailItemStatusNormal) {
        //去领取任务
        [self getTask];
    }
}

@end
