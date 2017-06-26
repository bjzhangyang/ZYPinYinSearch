//
//  ZYPinYinSearch.h
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYSearchModel.h"
@interface ZYPinYinSearch : NSObject



/**
 *  搜索数组，返回新的数组。目前支持NSString，NSDictionnary，自定义Model，后面两个可以指定按照哪个字段搜索
 *
 *  @param     originalArray      要搜索的数据源
 *  @param     searchText         搜索的文本
 *  @param     propertyName       按照字典中或者model中哪个字段搜索，如果数组中存的是NSString，则传@""即可
 *  @example   _dataSourceArray = [ZYPinYinSearch searchWithOriginalArray:_originalArray andSearchText:searchBar.text andSearchByPropertyName:@"name"];
 */
+(NSArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName NS_DEPRECATED_IOS(2_0, 2_0, "Use +searchByPropertyName: withOriginalArray: searchText: success: failure:, instead");

/**
 *  异步搜索，在数据量大的时候不阻塞主线程，在success里回调搜索结果，failure里回调错误信息
 */
+(void)searchByPropertyName:(NSString *)propertyName withOriginalArray:(NSArray *)originalArray searchText:(NSString *)searchText success:(void(^)(NSArray *results))success failure:(void(^)(NSString *errorMessage))failure;

/** 设置多音字情况下特定词语的拼音 */
+(void)setupReplacement:(ZYReplacement)relacement;
/** 清除自定义设置 */
+(void)removeReplacement;
@end
