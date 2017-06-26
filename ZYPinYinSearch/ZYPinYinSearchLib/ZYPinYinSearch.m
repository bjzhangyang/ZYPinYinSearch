//
//  ZYPinYinSearch.m
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYPinYinSearch.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "objc/runtime.h"

@implementation ZYPinYinSearch
+(void)setupReplacement:(ZYReplacement)relacement{
    [ZYSearchModel setupReplacement:relacement];
}
+(void)removeReplacement{
    [ZYSearchModel removeReplacement];
}
+(NSArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName{
    ZYSearchModel * searchModel = [ZYSearchModel new];
    searchModel.originalArray = originalArray;
    searchModel.searchText = searchText;
    searchModel.propertyName = propertyName;
    
    //如果数据合法，返回"string" 或者 "model" 或者 "dict"，不合法则返回错误信息
    NSString * type = [searchModel chekIsLegal];
    if (![@[@"string",@"model",@"dict"]containsObject:type]) {
        NSLog(@"%@",type);
        return originalArray;
    }
    return [searchModel search];
}

+(void)searchByPropertyName:(NSString *)propertyName withOriginalArray:(NSArray *)originalArray searchText:(NSString *)searchText success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    ZYSearchModel * searchModel = [ZYSearchModel new];
    searchModel.originalArray = originalArray;
    searchModel.searchText = searchText;
    searchModel.propertyName = propertyName;
    //如果数据合法，返回"string" 或者 "model" 或者 "dict"，不合法则返回错误信息
    NSString * type = [searchModel chekIsLegal];
    if (![@[@"string",@"model",@"dict"]containsObject:type]) {
        NSLog(@"%@",type);
        if (failure) {
            failure(type);
        }
        return;
    }
    __block NSArray * results ;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        results = [searchModel search];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(results);
            }
        });
    });
}
@end
