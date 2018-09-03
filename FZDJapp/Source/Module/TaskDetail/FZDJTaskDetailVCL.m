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
    NSDictionary *parameterDict = @{
                                    @"taskNo":self.taskNo.length > 0 ? self.taskNo:@""
                                    };
    [model loadItem:parameterDict success:^(NSDictionary *dict) {
        [weak_self refreshView];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - ================ 领取任务 ================

- (void)getTask{
    __weak typeof(self) weak_self = self;
    FZDJTaskDetailModel *model = (FZDJTaskDetailModel *)self.model;
   
    [model getTask:nil success:^(NSDictionary *dict) {
        [weak_self doTaskURL:model.item.taskUrl];
        [weak_self refreshStatusButton:FZDJTaskDetailItemStatusTaken];
    } failure:^(NSError *error) {
#warning 失败如何处理 TODU
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
//    htmlStr =  @"<p><span style=\"color: #FF8503; font-family: 'microsoft yahei', simhei;font-size: 16px; line-height: 28.8px; text-indent: 30px;\">今日，GMIC 2016正式在北京开幕，开幕仪式上，中关村发展集团总经理周云帆作了致辞演讲，他表示，“据统计2015年仅在这一年里面，中关村新创办的科技型企业达到了2.1万余家，很大一部分都是“互联网+”的企业。中关村的建设目标是到2020年要建设成为具有全球影响力的科技创新中心。”</span></p>";
    
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
    CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT - 50);
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    
//    NSURL *url = [NSURL URLWithString:[@"http://www.baidu.com" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    [webView.scrollView addSubview:self.headerView];
//    self.webView = webView;
//    [self.view addSubview:webView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.alwaysBounceVertical = YES;
    
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
        make.top.equalTo(self.headerView.mas_bottom);
        make.width.mas_equalTo(FX_SCREEN_WIDTH);
        make.left.equalTo(self.scrollView);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView).insets(UIEdgeInsetsMake(7, 10, 7, 10));
    }];
}

#pragma mark - ================ Lazzy Load ================

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        [_headerView addSubview:self.headerImageView];
        [_headerView addSubview:self.detailInfoView];

        [self.detailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImageView.mas_bottom);
            make.left.right.equalTo(_headerView);
            make.height.mas_equalTo(115);
        }];
        
        _headerView.width = FX_SCREEN_WIDTH;
        _headerView.height = self.headerImageView.height +
                            [FZDJTaskDetaiInfoView viewHeight];
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
