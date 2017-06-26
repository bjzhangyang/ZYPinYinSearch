//
//  ZYSearchModel.h
//  ZYPinYinSearch
//
//  Created by tarena on 17/6/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 自定义把汉语词组转化成拼音，处理多音字的情况 */
typedef NSDictionary * (^ZYReplacement)();
@interface ZYSearchModel : NSObject
@property (nonatomic,copy)NSArray  * originalArray;
@property (nonatomic,copy)NSString * searchText;
@property (nonatomic,copy)NSString * propertyName;
@property (nonatomic,copy)NSString * type;
-(NSString *)chekIsLegal;
-(NSArray *)search;

/** 设置多音字情况下特定词语的拼音 */
+(void)setupReplacement:(ZYReplacement)relacement;
+(void)removeReplacement;
@end
