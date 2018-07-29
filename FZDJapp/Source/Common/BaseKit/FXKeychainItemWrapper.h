//
//  FXKeychainItemWrapper.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXSingleton.h"

@interface FXKeychainItemWrapper : NSObject

@singleton(FXKeychainItemWrapper)

//Creating an item in the keychain
- (void)save:(NSString *)service data:(id)data;

//Searching the keychain
- (id)load:(NSString *)service;

//Deleting an item from the keychain
- (void)delete:(NSString *)service;
@end
