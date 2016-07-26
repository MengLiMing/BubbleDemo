
//
//  RandomHelp.m
//  BubbleDemo
//
//  Created by my on 16/7/23.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "RandomHelp.h"

#define ARC4RANDOM_MAX 0x100000000//arc4random()返回的最大值是 0x100000000

@implementation RandomHelp

//生成随机整数
+ (NSInteger)randomIntegerBetween:(NSInteger)min and:(NSInteger)max {
    NSInteger range = max - min;
    if (range == 0) {
        return min;
    }
    return arc4random()%range + min;
}
//生成随机小数
+ (CGFloat)randomFloatBetween:(CGFloat)min and:(CGFloat)max {
    CGFloat range = max - min;
    if (range == 0) {
        return min;
    }
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * range) + min;
}

@end
