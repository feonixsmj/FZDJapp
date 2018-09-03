//
//  FZDJDataModelSingleton.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/24.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJDataModelSingleton.h"

NSString *FZDJDataModelSingletonUserInfoKey = @"com.dj.userinfo";
NSString *FZDJDataModelSingletonIsNewInstallKey = @"com.dj.newinstall";

@interface FZDJDataModelSingleton()
@property (nonatomic, strong) NSUserDefaults *userDefault;
@end


@implementation FZDJDataModelSingleton
@def_singleton(FZDJDataModelSingleton)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userInfoData = [_userDefault objectForKey:FZDJDataModelSingletonUserInfoKey];
        FZDJUserInfo *info = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
        
        if (info) {
            self.userInfo = info;
        } else {
            self.userInfo = [[FZDJUserInfo alloc] init];
        }
        
    }
    return self;
}


- (BOOL)isNewIntall{
    
    id isNewValue = [_userDefault objectForKey:FZDJDataModelSingletonIsNewInstallKey];
    if (isNewValue) {
        return [isNewValue boolValue];
    }
    
    [_userDefault setObject:@(0) forKey:FZDJDataModelSingletonIsNewInstallKey];
    return YES;
}

- (void)setUserInfo:(FZDJUserInfo *)userInfo{
    _userInfo = userInfo;
    [self saveUserInfo];
}


- (void)saveData {
    
    if (self.userInfo) {
        [self saveUserInfo];
    }
    
    [_userDefault synchronize];
}

- (void)saveUserInfo{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
    [_userDefault setObject:data forKey:FZDJDataModelSingletonUserInfoKey];
    [_userDefault synchronize];
}

@end
