//
//  FZDJInvitationCodeVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/14.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJInvitationCodeVCL.h"
#import "FZDJInvitationCodeModel.h"
#import "FZDJInvitationCodeCell.h"

@interface FZDJInvitationCodeVCL ()<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *btnImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;
@end

@implementation FZDJInvitationCodeVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hiddenNavigationBar = YES;
        self.model = [[FZDJInvitationCodeModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dontNeedRefresh = YES;
    [self initUI];
    [self bringCloseButtonToFront];
    [self loadItem];
}

- (void)loadItem{
    FZDJInvitationCodeModel *model = (FZDJInvitationCodeModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [model loadDesc:nil success:^(NSDictionary *dict) {
        [weak_self refreshHeaderView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)refreshHeaderView{
    FZDJInvitationCodeModel *model = (FZDJInvitationCodeModel *)self.model;
    
    UILabel *desclabel = [[UILabel alloc] init];
    
    NSString *htmlStr = model.htmlStr;
    
    NSData *htmlData = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithData:htmlData
                                     options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                          documentAttributes:nil error:nil];
    
    desclabel.attributedText = attrStr;
    
    desclabel.textColor = [UIColor fx_colorWithHexString:@"6D3100"];
    desclabel.numberOfLines = 0;
    desclabel.font = [UIFont systemFontOfSize:13];
    desclabel.top = self.btnImageView.bottom + 22;

    CGFloat padding = 40;
    CGFloat width = FX_SCREEN_WIDTH - padding;
    CGSize size = [desclabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    desclabel.size = size;
    desclabel.centerX = self.btnImageView.centerX;
    [self.headerView addSubview:desclabel];
    
    CGRect rect = self.headerView.frame;
    rect.size.height = CGRectGetHeight(self.headerView.frame) + size.height + 22 - 40;
    
    self.headerView.frame = rect;
    self.bottomImageView.bottom = self.headerView.bottom;
    
}

- (void)initUI{
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.frame = CGRectMake(0, -FX_STATUSBAR_SPACE, FX_SCREEN_WIDTH,
                                      FX_SCREEN_HEIGHT + FX_STATUSBAR_SPACE);
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    
    [self.tableView registerNib:
          [UINib nibWithNibName:@"FZDJInvitationCodeCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJInvitationCodeCell"];
}

#pragma mark - ================ lazy load ================

- (UIView *)headerView{
    if (!_headerView) {
        UIView *view = [[UIView alloc] initWithFrame:
                        CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(377-102))];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(183))];
        imageView.image = [UIImage imageNamed:@"InvitationCode_bg"];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"邀请码";
        label.textColor = [UIColor fx_colorWithHexString:@"333333"];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.top = imageView.bottom - 20;
        label.size = CGSizeMake(100, 19);
        label.centerX = view.centerX;
        [view addSubview:label];
        
        UIImageView *btnImageView = [[UIImageView alloc] init];
        btnImageView.top = label.bottom +12;
        btnImageView.size = CGSizeMake(173, 38);
        btnImageView.centerX = view.centerX;
        btnImageView.image = [UIImage imageNamed:@"InvitationCode_btn"];
        btnImageView.userInteractionEnabled = YES;
        
        self.btnImageView = btnImageView;
        
        FZDJDataModelSingleton *dm =[ FZDJDataModelSingleton sharedInstance];
        UITextField *textField = [[UITextField alloc] init];
        textField.text = dm.userInfo.userShareCode;
        textField.textColor = [UIColor whiteColor];
        textField.frame = CGRectMake(0, 0, 173, 38);
        textField.font = [UIFont systemFontOfSize:18];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.inputView = [UIView new];
        textField.tintColor = [UIColor clearColor];
        textField.delegate = self;
        [btnImageView addSubview:textField];
        
        [view addSubview:btnImageView];
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"InvitationCode_bg2"];
        bottomView.size = CGSizeMake(FX_SCREEN_WIDTH, 19);
        bottomView.left = 0;
        bottomView.bottom = view.bottom;
        [view addSubview:bottomView];
        
        self.bottomImageView = bottomView;
        _headerView = view;
    }
    return _headerView;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string{
    return NO;
}


#pragma mark - ================ UITableView Delegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJInvitationCodeCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"FZDJInvitationCodeCell"];
    
    FZDJInvitationCodeItem *item = self.model.items[indexPath.row];
    cell.item = item;

    return cell;
}
@end
