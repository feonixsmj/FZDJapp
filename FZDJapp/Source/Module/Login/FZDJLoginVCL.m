//
//  FZDJLoginVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJLoginVCL.h"
#import "FXGuideView.h"
#import "FXImageView.h"

@interface FZDJLoginVCL ()

@property (weak, nonatomic) IBOutlet FXImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet FXImageView *phoneNumberIcon;
@property (weak, nonatomic) IBOutlet FXImageView *codeIcon;

@property (weak, nonatomic) IBOutlet UIView *thirdPartLoginView;


@end

@implementation FZDJLoginVCL


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断是否是第一安装 或者覆盖安装
    if (YES) {
        [self setGuidePage];
    }
    [self initUI];
}

- (void)initUI{
    self.backgroundImageView.image = [UIImage imageNamed:@"dj_guide_backgroud_image"];
    self.phoneNumberIcon.image = [UIImage imageNamed:@"phone_icon"];
    self.codeIcon.image = [UIImage imageNamed:@"yanzhen_icon"];
    self.getCodeButton.layer.cornerRadius = self.getCodeButton.height / 2;
    self.loginButton.layer.cornerRadius = self.loginButton.height / 2;
    
}

- (void)setGuidePage{
    //    guide_page1
    
    NSArray *imageNameArray = @[@"guide_page1",
                                @"guide_page2",
                                @"guide_page3",
                                @"guide_page4"];
    
    FXGuideView *guideView = [[FXGuideView alloc] initWithFrame:self.view.frame
                                                 imageNameArray:imageNameArray
                                                 buttonIsHidden:NO];
    
    [self.view addSubview:guideView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ================ ButtonClicked ================
- (IBAction)loginBtnDidClicked:(id)sender {
    NSLog(@"登录");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeLoginVCL)]) {
        [self.delegate closeLoginVCL];
    }
}
- (IBAction)getCodeButtonDidClicked:(id)sender {
}

- (IBAction)thirdPartLoginDidClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    
}



@end
