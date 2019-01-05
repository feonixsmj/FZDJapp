//
//  FZDJAboutUsVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/14.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAboutUsVCL.h"
#import "FZDJAboutUsModel.h"

@interface FZDJAboutUsVCL ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) FZDJAboutUsModel *aboutUsModel;
@end

@implementation FZDJAboutUsVCL

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    
    [self refureshLabelFrame];
    [self loadItem];
}

- (void)refureshLabelFrame{
    CGRect rect = self.contentLabel.frame;
    CGSize size = [self.contentLabel sizeThatFits:
                   CGSizeMake(self.contentLabel.width, CGFLOAT_MAX)];
    rect.size = size;
    self.contentLabel.frame = rect;
}

- (void)loadItem{
    self.aboutUsModel = [FZDJAboutUsModel new];
    
    __weak typeof(self) weak_self = self;
    [self.aboutUsModel loadItem:nil success:^(NSDictionary *dict) {
        
        NSString *htmlStr = self.aboutUsModel.htmlStr;
        NSData *htmlData = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *attrStr =
        [[NSAttributedString alloc] initWithData:htmlData
                                         options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                              documentAttributes:nil error:nil];
        
        weak_self.contentLabel.attributedText = attrStr;
        
        [weak_self refureshLabelFrame];
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
