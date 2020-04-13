//
//  linePesist.h
//  数据持久化(2)对象归档
//
//  Created by Azuo on 16/1/5.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface linePesist : NSObject<NSCoding, NSCopying>

@property (nonatomic, copy) NSArray *array;

@end
