//
//  FZDJPersonalCenterVCL.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/3.
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

const CGFloat FZDJPersonalInfoCellTotalHeight = 142.0f;

@interface FZDJPersonalCenterVCL ()<UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) FZDJHeaderImageView *headerImageView;
@property (nonatomic, strong) FZDJPersonalActionStrategy *strategy;
@end

@implementation FZDJPersonalCenterVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hiddenNavigationBar = YES;
        self.model = [[FZDJPersonalCenterModel alloc] init];
        self.strategy = [[FZDJPersonalActionStrategy alloc] initWithTarget:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
//    self.navigationController.delegate = self;
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
}


- (void)initUI{
//    UIBarButtonItem *rightItem =
//        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
//                                                      target:self
//                                                      action:@selector(closePage)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.headerImageView = [[FZDJHeaderImageView alloc] init];
    [self.view addSubview:self.headerImageView];
    
    [self addTableView];
    [self bringCloseButtonToFront];
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



#pragma mark - ================ LazyLoad ================

#pragma mark - ================ UINavigationControllerDelegate ================
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

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
