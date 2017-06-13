//
//  ZYSearchModel.h
//  ZYPinYinSearch
//
//  Created by tarena on 17/6/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYSearchModel : NSObject
@property (nonatomic,copy)NSArray  * originalArray;
@property (nonatomic,copy)NSString * searchText;
@property (nonatomic,copy)NSString * propertyName;
@property (nonatomic,copy)NSString * type;
-(NSString *)chekIsLegal;
-(NSArray *)search;
@end
