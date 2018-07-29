//
//  FZDJBannerVo.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/26.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBaseBVO.h"

@interface FZDJBannerVo : FZDJBaseBVO

@property (nonatomic, assign) NSInteger bannerID;
@property (nonatomic, copy  ) NSString *lbContentUrl;
@property (nonatomic, copy  ) NSString *lbTitle;
@property (nonatomic, copy  ) NSString *lbimgUrl;
@property (nonatomic, assign) NSInteger lbSort;
@property (nonatomic, copy  ) NSString *clickEvent;
@property (nonatomic, copy  ) NSString *lbContent;
@property (nonatomic, copy  ) NSString *lbNo;
@end
