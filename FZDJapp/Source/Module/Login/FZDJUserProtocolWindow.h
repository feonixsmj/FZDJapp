//
//  FZDJUserProtocolWindow.h
//  FZDJapp
//
//  Created by smj on 2019/1/5.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FZDJUserProtocolWindowCloseBlock)(void);

@interface FZDJUserProtocolWindow : UIWindow

@property (nonatomic, copy) FZDJUserProtocolWindowCloseBlock closeblock;
- (void)show;

- (void)hide;
@end


