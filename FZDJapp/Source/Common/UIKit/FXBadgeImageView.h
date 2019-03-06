//
//  FXBadgeImageView.h
//  FZDJapp
//
//  Created by FZYG on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FXBadgeImageView : UIImageView
@property (nonatomic, strong)UIImage *backgroundImage;
@property (nonatomic, strong)NSString *badgeValue;
@property (nonatomic, strong)UILabel *badgeLab;

- (void)showMore;
@end

