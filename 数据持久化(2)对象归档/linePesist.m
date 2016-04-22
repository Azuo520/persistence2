//
//  linePesist.m
//  数据持久化(2)对象归档
//
//  Created by Azuo on 16/1/5.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import "linePesist.h"
#define CodeStr   @"CodeStr"

@implementation linePesist
/*
    通过遵循NSCoding和NSCoping中的方法，创建可归档的数据对象。
 */

#pragma mark -- Coding
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.array forKey:CodeStr];
}
//解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.array = [aDecoder decodeObjectForKey:CodeStr];
    }
    return self;
}

#pragma mark -- Coping

-(id)copyWithZone:(NSZone *)zone
{
    linePesist *copy = [[[self class]allocWithZone:zone] init];
    NSMutableArray *muAr = [[NSMutableArray alloc]init];
    for(id line in self.array)
    {
        [muAr addObject:[line copyWithZone:zone]];
    }
    copy.array = muAr;
    return copy;
}
@end
