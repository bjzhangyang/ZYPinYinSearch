# ZYPinYinSearch
iOS汉字拼音搜索
1.导入ZYPinYinSearchLib文件夹到自己项目中
2.#import "ZYPinYinSearch.h"
3.调用方法
/**
 *  搜索数组，返回新的数组。目前支持NSString，NSDictionnary，自定义Model，后面两个可以指定按照哪个字段搜索
 *
 *  @param     originalArray      要搜索的数据源
 *  @param     searchText         搜索的文本
 *  @param     propertyName       按照字典中或者model中哪个字段搜索，如果数组中存的是NSString，则传@""即可
 *  @example   _dataSourceArray = [ZYPinYinSearch searchWithOriginalArray:_originalArray andSearchText:searchBar.text andSearchByPropertyName:@"name"];
 */
+(NSArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName;
