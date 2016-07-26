//
//  BubbleLayer.h
//  BubbleDemo
//
//  Created by my on 16/7/23.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface BubbleLayer : CALayer

- (instancetype)initWithPosition:(CGPoint)position;
- (void)setImage:(UIImage *)image andHeight:(CGFloat)height;


///添加到view
- (void)addToView:(UIView *)view;

///移动view
- (void)moveFrom:(CGPoint)from to:(CGPoint)to duration:(CGFloat)duration;


+ (void)biggerAndDismiss:(CALayer *)layer time:(CGFloat)time;

@end
