//
//  FXBaseModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"

@implementation FXBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = 10;
        self.pageNumber = 1;
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure{
    
}

- (void)clean {
    self.pageSize = 10;
    self.pageNumber = 1;
    self.items = [NSMutableArray arrayWithCapacity:5];
}

- (void)plusPageNumber{
    self.pageNumber += 1;
}
@end
