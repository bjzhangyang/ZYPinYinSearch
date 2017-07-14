

//
//  ZYSearchModel.m
//  ZYPinYinSearch
//
//  Created by soufun on 17/6/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYSearchModel.h"
#import "objc/runtime.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
static const char ZYReplacementKey = '\0';
static const char ZYCachedProperties = '\0';
@implementation ZYSearchModel
-(NSString *)chekIsLegal{
    NSString * type;
    if(self.originalArray.count <= 0){
        return @"数据源不能为空";
    }
    else{
        id object = self.originalArray[0];
        if ([object isKindOfClass:[NSString class]]) {
            type = @"string";
        }
        else if([object isKindOfClass:[NSDictionary class]]){
            type = @"dict";
            NSDictionary * dict = self.originalArray[0];
            BOOL isExit = NO;
            for (NSString * key in dict.allKeys) {
                if([key isEqualToString:self.propertyName]){
                    isExit = YES;
                    break;
                }
            }
            if (!isExit) {
                return [NSString stringWithFormat:@"数据源中的字典没有你指定的key:%@",self.propertyName];
            }
        }
        else{
            type = @"model";
            NSMutableArray *cachedProperties = objc_getAssociatedObject([object class], &ZYCachedProperties);
            if (!cachedProperties) {
                cachedProperties = [NSMutableArray array];
                Class c = [object class];
                while (c && c != [NSObject class]) {
                    unsigned int outCount, i;
                    objc_property_t *properties = class_copyPropertyList(c, &outCount);
                    for (i = 0; i<outCount; i++)
                    {
                        objc_property_t property = properties[i];
                        const char* char_f = property_getName(property);
                        NSString *property_name = [NSString stringWithUTF8String:char_f];
                        [cachedProperties addObject:property_name];
                    }
                    free(properties);
                    c = class_getSuperclass(c);
                }
                objc_setAssociatedObject([object class], &ZYCachedProperties, cachedProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            if(![cachedProperties containsObject:self.propertyName]){
                return [NSString stringWithFormat:@"数据源中的Model没有你指定的属性:%@",self.propertyName];
            }
        }
    }
    _type = type;
    return type;
}

-(NSArray *)search{
    NSMutableArray * dataSourceArray = [NSMutableArray array];
    if (self.searchText.length>0&&![ChineseInclude isIncludeChineseInString:self.searchText]) {
        for (int i=0; i<self.originalArray.count; i++) {
            NSString * tempString;
            if ([_type isEqualToString:@"string"]) {
                tempString = _originalArray[i];
            }
            else{
                tempString = [_originalArray[i]valueForKey:_propertyName];
            }
            NSDictionary * replacementDic = objc_getAssociatedObject([self class], &ZYReplacementKey);
            if(replacementDic){
                for (NSString * key in replacementDic.allKeys) {
                    if ([tempString containsString:key]) {
                        tempString = [tempString stringByReplacingOccurrencesOfString:key withString:[replacementDic objectForKey:key]];
                    }
                }
            }
            if ([ChineseInclude isIncludeChineseInString:tempString]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:tempString];
                NSRange titleResult=[tempPinYinStr rangeOfString:_searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:self.originalArray[i]];
                    continue;
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:tempString];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:self.searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [dataSourceArray addObject:self.originalArray[i]];
                    continue;
                }
            }
            else {
                NSRange titleResult=[tempString rangeOfString:self.searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:self.originalArray[i]];
                    continue;
                }
            }
        }
    } else if (_searchText.length>0&&[ChineseInclude isIncludeChineseInString:self.searchText]) {
        for (id object in self.originalArray) {
            NSString * tempString;
            if ([self.type isEqualToString:@"string"]) {
                tempString = object;
            }
            else{
                tempString = [object valueForKey:self.propertyName];
            }
            NSRange titleResult=[tempString rangeOfString:self.searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [dataSourceArray addObject:object];
            }
        }
    }
    return [dataSourceArray copy];
}

+(void)setupReplacement:(ZYReplacement)relacement{
    if (relacement && [relacement() isKindOfClass:[NSDictionary class]]) {
        objc_setAssociatedObject(self, &ZYReplacementKey, relacement(), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        objc_setAssociatedObject(self, &ZYReplacementKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
+(void)removeReplacement{
    objc_setAssociatedObject(self, &ZYReplacementKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
