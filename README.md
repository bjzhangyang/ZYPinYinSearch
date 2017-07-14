
## ZYPinYinSearch是什么?
一个筛选库，可以把数组里的内容按照拼音筛选出来。

## ZYPinYinSearch有哪些功能？

* 搜索功能
*  数据源可以是字符串的数组
*  数据源可以是字典的数组，按照某个字段搜索
*  数据源可以是自定义Model的数组，按照某个字段搜索
* 自定义多音字功能。可以指定某个词语或者汉字为某个拼音，仅需设置一次，在APP运行过程中都有效

## ZYPinYinSearch怎么用
```javascript
/**
*  搜索数组，返回新的数组。目前支持NSString，NSDictionnary，自定义Model，后面两个可以指定按照哪个字段搜索
*
*  @param     originalArray      要搜索的数据源
*  @param     searchText         搜索的文本
*  @param     propertyName       按照字典中或者model中哪个字段搜索，如果数组中存的是NSString，则传@""即可
*/
[ZYPinYinSearch searchByPropertyName:@"name" withOriginalArray:_originalArray searchText:searchBar.text success:^(NSArray *results) {
_dataSourceArray = results;
[_tableView reloadData];
} failure:^(NSString *errorMessage) {

}];

//处理多音字，指定词组的拼音，指定一次，整个APP运行过程中都有效，可以手动清除
[ZYPinYinSearch setupReplacement:^NSDictionary *{
return @{@"长春":@"changchun",@"重庆":@"chongqing"};//长春默认是"zhangchun"，所以咱们这里可以特殊设置成"changchun"
}];
```
## 安装
1、pod 'ZYPinYinSearch'
2、或者直接把ZYPinYinSearchLib拖入项目即可
![img](https://github.com/bjzhangyang/ZYPinYinSearch/blob/master/2017-06-27%2010_57_40.gif)
