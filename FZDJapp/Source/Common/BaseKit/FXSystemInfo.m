//
//  FXSystemInfo.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/20.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXSystemInfo.h"
#import "FXKeychainItemWrapper.h"
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"
#import "FXCrypto.h"

@implementation FXSystemInfo

+ (NSString *)orginalIdfa {
    
    NSString *idfaKey = @"onemtOrginalIdfa";
    
    //先查userDefault
    NSString *mbIdfaStr = [[NSUserDefaults standardUserDefaults] stringForKey:idfaKey];
    
    if (mbIdfaStr &&
        ![mbIdfaStr isEqualToString:@""] &&
        ![mbIdfaStr isEqualToString:@"00000000-0000-0000-0000-000000000000"])
    {
        return mbIdfaStr.uppercaseString;
    }
    
    //在查kechain
    NSString *keychainIdfa = [[FXKeychainItemWrapper sharedInstance] load:idfaKey];
    if (keychainIdfa &&
        ![keychainIdfa isEqualToString:@""] &&
        ![keychainIdfa isEqualToString:@"00000000-0000-0000-0000-000000000000"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:keychainIdfa forKey:idfaKey];
        return keychainIdfa.uppercaseString;
    }
    
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([adId isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        adId = [FXCrypto md5:[FXSystemInfo openUDID]].uppercaseString;
        NSMutableString *resultAdid = [NSMutableString stringWithString:adId];
        [resultAdid insertString:@"-" atIndex:8];
        [resultAdid insertString:@"-" atIndex:13];
        [resultAdid insertString:@"-" atIndex:18];
        [resultAdid insertString:@"-" atIndex:23];
        adId = resultAdid;
    }
    [[NSUserDefaults standardUserDefaults] setValue:adId forKey:idfaKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[FXKeychainItemWrapper sharedInstance] save:idfaKey data:adId];
    if (adId.length == 0) {
        adId = @"00000000-0000-0000-0000-000000000000";
    }
    return adId;
}


+ (NSString *)openUDID {
    
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    Class openUDID = NSClassFromString( @"OpenUDID" );
    if ( openUDID )
    {
        return [openUDID value];
    }
    else
    {
        return @"";
    }
#else    // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return @"";
#endif    // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

@end
