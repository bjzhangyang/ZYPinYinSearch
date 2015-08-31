

//
//  Person.m
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "Person.h"

@implementation Person
+(Person *)CreatePersonWithName:(NSString*)name andNickname:(NSString*)nickname{
    Person * person = [[Person alloc]init];
    person.name = name;
    person.nickname = nickname;
    return person;
}
@end
