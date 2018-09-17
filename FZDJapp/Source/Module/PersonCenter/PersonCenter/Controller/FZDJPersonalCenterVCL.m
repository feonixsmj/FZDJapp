//
//  FZDJPersonalCenterVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJPersonalCenterVCL.h"
#import "FZDJPersonalInfoCell.h"
#import "FZDJPeraonalListCell.h"
#import "FZDJPersonalBlankCell.h"
#import "FZDJTaskCell.h"
#import "FZDJPersonalCenterModel.h"
#import "FZDJHeaderImageView.h"
#import "FZDJPersonalActionStrategy.h"
#import "FZDJLoginVCL.h"
#import "FZDJUploadImageModel.h"
#import "FZDJEditInfoModel.h"
#import "FZDJMainVCL.h"

const CGFloat FZDJPersonalInfoCellTotalHeight = 142.0f;

@interface FZDJPersonalCenterVCL ()<UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource,
FZDJLoginVCLDelegate>

@property (nonatomic, strong) FZDJHeaderImageView *headerImageView;
@property (nonatomic, strong) FZDJPersonalActionStrategy *strategy;
@property (nonatomic, strong) FZDJUploadImageModel *uploadImageModel;
@property (nonatomic, strong) FZDJEditInfoModel *editInfoModel;
@property (nonatomic, strong) UIButton *statusButton;
@end

@implementation FZDJPersonalCenterVCL

- (void)reloadData{
    FZDJPersonalCenterModel *model = (FZDJPersonalCenterModel *)self.model;
    [model updateData];
    [self.tableView reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hiddenNavigationBar = YES;
        self.model = [[FZDJPersonalCenterModel alloc] init];
        self.uploadImageModel = [[FZDJUploadImageModel alloc] init];
        self.strategy = [[FZDJPersonalActionStrategy alloc] initWithTarget:self];
        self.editInfoModel = [[FZDJEditInfoModel alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    self.title = @"个人中心";
    self.dontNeedRefresh = YES;
    
    [self initUI];
    [self loadItem];
}

- (void)loadItem{
    FZDJPersonalCenterModel *model = (FZDJPersonalCenterModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [model loadCustomServer:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (void)initUI{
    self.headerImageView = [[FZDJHeaderImageView alloc] init];
    [self.view addSubview:self.headerImageView];
    
    [self addTableView];
    [self bringCloseButtonToFront];
    
    [self.view addSubview:self.statusButton];
    
}

- (void)addTableView{
    self.tableView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCREEN_HEIGHT - 50);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJPersonalInfoCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJPersonalInfoCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJPeraonalListCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJPeraonalListCell"];
    
    [self.tableView registerClass:[FZDJTaskCell class]
           forCellReuseIdentifier:@"FZDJTaskCell"];
    [self.tableView registerClass:[FZDJPersonalBlankCell class]
           forCellReuseIdentifier:@"FZDJPersonalBlankCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - ================ 上传头像 ================

- (void)uploadImage:(UIImage *)image{
    __weak typeof(self) weak_self = self;
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    [self.uploadImageModel uploadImage:image success:^(NSDictionary *dict) {
        NSString *url = dict[@"url"];
        if (url.length > 0) {
            dm.userInfo.avatarURL = url;
            [weak_self reloadData];
            [weak_self modifyAvatar];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)modifyAvatar{
    [self.editInfoModel modifyPersonalInfo:nil success:^(NSDictionary *dict) {
        NSLog(@"替换成功");
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - ================ LazyLoad ================

- (UIButton *)statusButton{
    if (!_statusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"dj_personcenter_quit"]
                forState:UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(logoutButtonAction)
         forControlEvents:UIControlEventTouchUpInside];;
        
        CGRect rect = CGRectMake(10, FX_SCREEN_HEIGHT - 10 - 37,
                                 FX_SCREEN_WIDTH - 10 *2, 37);
        button.frame = rect;
        _statusButton = button;
    }
    return _statusButton;
}

- (void)logoutButtonAction{
    //退出登录
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    dm.userInfo.nickName = nil;
    dm.userInfo.openid = nil;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FZDJLoginVCL" bundle:nil];
    FZDJLoginVCL *loginVCL = (FZDJLoginVCL *)[storyBoard instantiateInitialViewController];
    
    
    for (UIViewController *vcl in self.navigationController.childViewControllers) {
        if (![vcl isKindOfClass:NSClassFromString(@"FZDJMainVCL")]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            FZDJMainVCL *mainvcl = (FZDJMainVCL *)vcl;
            loginVCL.delegate = mainvcl;
            [mainvcl.navigationController presentViewController:loginVCL animated:NO completion:nil];
        }
    }
    
    
}

#pragma mark ================ FZDJLoginVCLDelegate ================
- (void)loginSuccess{
    // 关闭登录弹窗
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self loadItem];
}

#pragma mark - ================ UITableViewDelegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *item = self.model.items[indexPath.row];
    if ([item isKindOfClass:[FZDJPersonalInfoItem class]]) {
        FZDJPersonalInfoCell *cell = [tableView
                dequeueReusableCellWithIdentifier:@"FZDJPersonalInfoCell"];
        FZDJPersonalInfoItem *infoItem = (FZDJPersonalInfoItem *)item;
        cell.delegate = self.strategy;
        cell.item = infoItem;
        return cell;
    } else if([item isKindOfClass:[FZDJPersonalListItem class]]){
        FZDJPeraonalListCell *cell = [tableView
                dequeueReusableCellWithIdentifier:@"FZDJPeraonalListCell"];
        FZDJPersonalListItem *listItem = (FZDJPersonalListItem *)item;
        cell.item = listItem;
        return cell;
    } else if([item isKindOfClass:[FZDJPersonalBlankItem class]]){
        FZDJPersonalBlankCell *cell = [tableView
            dequeueReusableCellWithIdentifier:@"FZDJPersonalBlankCell"];
        
        return cell;
    } else {
        FZDJTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJTaskCell"];
        cell.mainView.delegate = self.strategy;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *item = self.model.items[indexPath.row];
    if ([item isKindOfClass:[FZDJPersonalInfoItem class]]) {
        CGFloat height = FZDJPersonalInfoCellTotalHeight - 10 - FX_STATUSBAR_SPACE;
        return height;//personalInfo
    } else if([item isKindOfClass:[FZDJPersonalListItem class]]){
        return 47.0f;//list
    } else if([item isKindOfClass:[FZDJPersonalBlankItem class]]){
        return 10.0f;//blank
    } else {
        return 122.0f;//task
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *item = self.model.items[indexPath.row];
    if ([item isKindOfClass:[FZDJPersonalListItem class]]) {
        FZDJPersonalListItem *listItem = (FZDJPersonalListItem *) item;
        [self.strategy personalCellActionForwarder:listItem.actionType];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


    CGRect newFrame = self.headerImageView.frame;
    CGFloat height = FZDJHeaderImageViewHeight - FX_STATUSBAR_SPACE;

    CGFloat settingViewOffsetY = height - scrollView.contentOffset.y;
    newFrame.size.height = settingViewOffsetY;

    if (settingViewOffsetY < FZDJHeaderImageViewHeight) {
        newFrame.size.height = FZDJHeaderImageViewHeight;
    }
    self.headerImageView.frame = newFrame;
}

@end
