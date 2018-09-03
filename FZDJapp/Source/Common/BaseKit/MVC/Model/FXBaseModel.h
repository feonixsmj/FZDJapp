//
//  FXBaseModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/6/26.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseModel : NSObject

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;
/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *items;

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure;

/**
 下拉刷新重置数据
 */
- (void)clean;


/**
 上拉成功 页数+1
 */
- (void)plusPageNumber;
@end
