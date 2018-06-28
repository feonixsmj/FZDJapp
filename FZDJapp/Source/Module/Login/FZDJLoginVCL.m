//
//  FZDJLoginVCL.m
//  FZDJapp
//
//  Created by suminjie on 2018/6/25.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJLoginVCL.h"
#import "FXGuideView.h"
#import "FXImageView.h"

@interface FZDJLoginVCL ()

@property (weak, nonatomic) IBOutlet FXImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;


@property (weak, nonatomic) IBOutlet FXImageView *phoneNumberIcon;
@property (weak, nonatomic) IBOutlet FXImageView *codeIcon;

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
    self.backgroundImageView.image = [UIImage imageNamed:@"backgroud_icon"];
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
- (IBAction)loginBtnDidClicked:(id)sender {
    NSLog(@"登录");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeLoginVCL)]) {
        [self.delegate closeLoginVCL];
    }
}
- (IBAction)getCodeButtonDidClicked:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
