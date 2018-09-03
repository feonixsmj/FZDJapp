//
//  FZDJBannerDetailVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/3.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBannerDetailVCL.h"

@interface FZDJBannerDetailVCL ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *htmlLabel;
@end

@implementation FZDJBannerDetailVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    [self createHtmlLabel];
}

- (void)createHtmlLabel{
    
    self.htmlLabel = [[UILabel alloc] init];
    self.htmlLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.htmlLabel];
    
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

@end
