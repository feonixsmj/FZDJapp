//
//  FZDJUserProtocolView.h
//  FZDJapp
//
//  Created by smj on 2019/1/5.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBlock)(void);

@interface FZDJUserProtocolView : UIView

@property (nonatomic, copy) CloseBlock closeBlock;
@end

