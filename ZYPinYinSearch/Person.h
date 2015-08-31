//
//  Person.h
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * age;
+(Person *)CreatePersonWithName:(NSString*)name andNickname:(NSString*)nickname;
@end
