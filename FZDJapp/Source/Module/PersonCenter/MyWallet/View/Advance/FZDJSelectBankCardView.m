//
//  FZDJSelectBankCardView.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJSelectBankCardView.h"
#import "FZDJSelectBankCardCell.h"
#import "FZDJBanklistItem.h"

@interface FZDJSelectBankCardView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FZDJSelectBankCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contentViewHeight = 250;
        
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.64];
        self.layer.opacity = 0.0;
        
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
//        self.userInteractionEnabled = YES;
//        [self addGestureRecognizer:tap];
        
        [self addSubview:self.contentView];
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.cancelButton];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.tableView];
        
    }
    return self;
}

- (void)clickConfirmButton{
    [self disMiss];
}

- (void)clickCancelButton{
    [self disMiss];
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameContent =  self.contentView.frame;
    
    frameContent.origin.y -= self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)disMiss{
    CGRect frameContent =  self.contentView.frame;
    frameContent.origin.y += self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:0.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setContentViewHeight:(CGFloat)contentViewHeight{
    _contentViewHeight = contentViewHeight;
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, contentViewHeight);
}


- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, FX_SCREEN_HEIGHT, FX_SCREEN_WIDTH, self.contentViewHeight)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_cancelButton setImage:[UIImage imageNamed:@"navigation_close_btn"]
                       forState:UIControlStateNormal];

        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(44, 0,FX_SCREEN_WIDTH - 44*2, 44)];
        _titleLabel.text = @"选择付款方式";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor fx_colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, FX_SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor fx_colorWithHexString:@"#E9E9E9"];
        
        _lineView = lineView;
    }
    return _lineView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, self.lineView.bottom, FX_SCREEN_WIDTH, self.contentViewHeight -44);
        UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        [tableView registerNib:[UINib nibWithNibName:@"FZDJSelectBankCardCell" bundle:nil]
             forCellReuseIdentifier:@"FZDJSelectBankCardCell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50.0f;
        
        _tableView = tableView;
    }
    
    return _tableView;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self.tableView reloadData];
}

#pragma mark - ================ UITableViewDelegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJBanklistItem *item = (FZDJBanklistItem *)self.dataArray[indexPath.row];
    
    FZDJSelectBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJSelectBankCardCell"];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(FZDJSelectBankCardViewDidSelectedIndexPath:)]) {
        [self disMiss];
        [self.delegate FZDJSelectBankCardViewDidSelectedIndexPath:indexPath];
    }
}
@end
