//
//  FZDJAppealViewController.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealViewController.h"
#import "FZDJAppealModel.h"
#import "FZDJAppealTaskInfoView.h"
#import "FZDJQuestionDescView.h"
#import "FZDJSelectPhotoView.h"
#import "FZDJAppealHistoryCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FZDJAppealSelectPhotoStrategy.h"
#import "FZDJUploadImageModel.h"

CGFloat const FZDJAppealTaskInfoViewHeight = 111.0f;

@interface FZDJAppealViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) FZDJAppealTaskInfoView *taskInfoView;
@property (nonatomic, strong) FZDJQuestionDescView *questionDescView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, strong) FZDJAppealSelectPhotoStrategy *strategy;
@property (nonatomic, strong) FZDJSelectPhotoView *selectPhotoView;
@property (nonatomic, strong) FZDJUploadImageModel *uploadImageModel;
@property (nonatomic, strong) NSMutableArray *imageUrls;
@end

@implementation FZDJAppealViewController

- (void)dealloc
{
    NSLog(@"dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJAppealModel alloc] init];
        self.strategy = [[FZDJAppealSelectPhotoStrategy alloc] initWithTarget:self];
        self.imageUrls = [NSMutableArray arrayWithCapacity:1];
        self.uploadImageModel = [[FZDJUploadImageModel alloc] init];
    }
    return self;
}

- (void)setTaskItem:(FZDJMyTaskItem *)taskItem{
    _taskItem = taskItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dontNeedRefresh = YES;
    self.title = @"申述";
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    [self createUI];
    
    [self loadItem];
}

- (void)createUI{
    self.tableView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT - 50);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJAppealHistoryCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJAppealHistoryCell"];
    
    self.tableView.tableHeaderView = self.headerView;
    
}


- (void)addBottomBarIfNeeded{
    //申诉中 已关闭 不显示提交按钮 且不展示问题描述
    if (self.taskItem.status == FXMyTaskItemStatusClose ||
        self.taskItem.status == FXMyTaskItemStatusAppealing) {
        
        self.questionDescView.hidden = YES;
        [self.questionDescView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.headerView.height = FZDJAppealTaskInfoViewHeight;
        self.tableView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
        return;
    }
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.statusButton];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-FX_BOTTOM_SPAGE);
        make.height.mas_equalTo(50);
    }];
    
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView).insets(UIEdgeInsetsMake(7, 10, 7, 10));
    }];
}


- (void)loadItem{
    __weak typeof(self) weak_self = self;
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:2];
    parameter[@"taskInstNo"] = self.taskItem.taskInstNo;
    
    [model loadItem:parameter success:^(NSDictionary *dict) {
        weak_self.taskItem = model.item;
        [weak_self loadAppealHistoryIfNeeded];
        [weak_self refreshUI];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadAppealHistoryIfNeeded{
    __weak typeof(self) weak_self = self;
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:2];
    parameter[@"taskInstNo"] = self.taskItem.taskInstNo;
    
    if (self.taskItem.status != FXMyTaskItemStatusNone &&
        self.taskItem.status != FXMyTaskItemStatusAppeal) {
        //不是 申述 和 完成状态 都显示申述历史
        [model loadAppealHistory:parameter success:^(NSDictionary *dict) {
            //刷新table
            [weak_self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)refreshUI{
    self.taskInfoView.item = self.taskItem;
    
    [self addBottomBarIfNeeded];
}

#pragma mark - ================ 上传图片 ================

- (void)uploadImage:(UIImage *)image{
    __weak typeof(self) weak_self = self;
    [self.uploadImageModel uploadImage:image success:^(NSDictionary *dict) {
        NSString *url = dict[@"url"];
        if (url.length > 0) {
            [weak_self.imageUrls addObject:url];
            weak_self.selectPhotoView.imageUrls = weak_self.imageUrls;
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - ================ Lazy load ================

- (UIView *)headerView{
    if(!_headerView){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FX_SCREEN_WIDTH, 328)];
        
        UIView *containerView = [[UIView alloc] init];
        
        [headerView addSubview:containerView];
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView).insets(UIEdgeInsetsMake(5, 10, 0, 10));
        }];
        
        [containerView addSubview:self.taskInfoView];
        
        [self.taskInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(containerView);
            make.height.mas_equalTo(FZDJAppealTaskInfoViewHeight);
        }];
        
        [containerView addSubview:self.questionDescView];
        
        [self.questionDescView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(self.taskInfoView.mas_bottom);
             make.left.right.bottom.equalTo(containerView);
         }];
        
        [self.questionDescView.pictureContainView addSubview:self.selectPhotoView];
        
        [self.selectPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.questionDescView.pictureContainView);
        }];
        
        _headerView = headerView;
    }
    
    return _headerView;
}

- (FZDJAppealTaskInfoView *)taskInfoView{
    if(!_taskInfoView){
        _taskInfoView =
            [[[NSBundle mainBundle] loadNibNamed:@"FZDJAppealTaskInfoView"
                                           owner:self
                                         options:nil] lastObject];
        _taskInfoView.item = self.taskItem;
    }
    return _taskInfoView;
}

- (FZDJQuestionDescView *)questionDescView{
    if(!_questionDescView) {
        _questionDescView =
            [[[NSBundle mainBundle] loadNibNamed:@"FZDJQuestionDescView"
                                           owner:self
                                         options:nil] lastObject];
        
    }
    
    return _questionDescView;
}

- (FZDJSelectPhotoView *)selectPhotoView{
    if (!_selectPhotoView) {
        _selectPhotoView = [[FZDJSelectPhotoView alloc] init];
        __weak typeof(self) weak_self = self;
        _selectPhotoView.addPhotoBlcok = ^{
            [weak_self.strategy presentSelectPhotoAlertView];
        };
    }
    return _selectPhotoView;
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
        [button setImage:[UIImage imageNamed:@"dj_task_tijiao_btn"]
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonAction)
         forControlEvents:UIControlEventTouchUpInside];
//        button.enabled = NO;
        _statusButton = button;
    }
    return _statusButton;
}

- (void)buttonAction{

    MBProgressHUD *hud = [MBProgressHUD new];
    hud.detailsLabel.text = @"提交中...";
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    
    NSMutableDictionary *parameterDict = [NSMutableDictionary dictionary];
    parameterDict[@"complaintContent"] = self.questionDescView.textView.text;
    parameterDict[@"imgs"] = self.imageUrls;
    parameterDict[@"taskInstNo"] = self.taskItem.taskInstNo;
    
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model submitAppeal:parameterDict success:^(NSDictionary *dict) {
        
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = @"申述成功!";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
            dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [hud hideAnimated:YES];
        hud.detailsLabel.text = @"失败";
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
}

#pragma mark - ================ UITabelView Delegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    return model.historyItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FZDJAppealHistoryCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"FZDJAppealHistoryCell"];
    
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    FZDJAppealHistoryItem *item = model.historyItems[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FZDJAppealModel *model = (FZDJAppealModel *)self.model;
    FZDJAppealHistoryItem *item = model.historyItems[indexPath.row];
    
    return [tableView fd_heightForCellWithIdentifier:@"FZDJAppealHistoryCell" configuration:^(FZDJAppealHistoryCell *cell) {
        cell.item = item;
    }];
    
}
@end
