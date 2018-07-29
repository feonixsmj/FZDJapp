//
//  FZDJAboutUsVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/14.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAboutUsVCL.h"

@interface FZDJAboutUsVCL ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation FZDJAboutUsVCL

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    
    CGRect rect = self.contentLabel.frame;
    CGSize size = [self.contentLabel sizeThatFits:
                            CGSizeMake(self.contentLabel.width, CGFLOAT_MAX)];
    rect.size = size;
    self.contentLabel.frame = rect;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
