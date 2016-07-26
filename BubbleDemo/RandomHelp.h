//
//  RandomHelp.h
//  BubbleDemo
//
//  Created by my on 16/7/23.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface RandomHelp : NSObject

///生成随机整数
+ (NSInteger)randomIntegerBetween:(NSInteger)min and:(NSInteger)max;
///生成随机小数
+ (CGFloat)randomFloatBetween:(CGFloat)min and:(CGFloat)max;

@end
