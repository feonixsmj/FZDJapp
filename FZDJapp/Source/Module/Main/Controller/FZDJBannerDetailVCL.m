//
//  FZDJBannerDetailVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/3.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBannerDetailVCL.h"

@interface FZDJBannerDetailVCL ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *htmlLabel;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation FZDJBannerDetailVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.htmlStr baseURL:nil];
//    [self.view addSubview:self.scrollView];
    
//    [self createHtmlLabel];
}

- (void)createHtmlLabel{
    
    self.htmlLabel = [[UILabel alloc] init];
    self.htmlLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.htmlLabel];
    
    self.htmlLabel.userInteractionEnabled = YES;
    [self.htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.scrollView.mas_left);
        make.width.mas_equalTo(FX_SCREEN_WIDTH);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom);
    }];

    NSData *htmlData = [self.htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithData:htmlData
                                     options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                          documentAttributes:nil error:nil];
    
    
    self.htmlLabel.attributedText = attrStr;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
        _scrollView = [[UIScrollView alloc] initWithFrame:rect];
        _scrollView.contentSize = CGSizeMake(FX_SCREEN_WIDTH-10,FX_TABLE_HEIGHT);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIWebView *)webView{
    if (!_webView) {
        CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
        _webView = [[UIWebView alloc] initWithFrame:rect];
        _webView.scrollView.contentSize = CGSizeMake(FX_SCREEN_WIDTH-10, FX_TABLE_HEIGHT);
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.delegate = self;
//        _webView.scrollView.delegate = self;
    }
    return _webView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD wb_showActivity];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD wb_hideHUD];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint point = scrollView.contentOffset;
//    if (point.x > 0||point.x <0) {
//        scrollView.contentOffset = CGPointMake(0, point.y);
//    }
//}



@end
