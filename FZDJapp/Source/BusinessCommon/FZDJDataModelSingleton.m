//
//  FZDJDataModelSingleton.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJDataModelSingleton.h"

NSString *FZDJDataModelSingletonUserInfoKey = @"com.dj.userinfo";

@implementation FZDJDataModelSingleton
@def_singleton(FZDJDataModelSingleton)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userInfoData = [userDefault objectForKey:FZDJDataModelSingletonUserInfoKey];
        FZDJUserInfo *info = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
        
        if (info) {
            self.userInfo = info;
        } else {
            self.userInfo = [[FZDJUserInfo alloc] init];
        }
        
    }
    return self;
}


- (void)save {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:FZDJDataModelSingletonUserInfoKey];
    
    [userDefault synchronize];
}
@end
