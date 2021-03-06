//
//  BubbleLayer.m
//  BubbleDemo
//
//  Created by my on 16/7/23.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "BubbleLayer.h"

@implementation BubbleLayer {
    //
    UIImage *bubbleImage;
    CGFloat bubbleHeight;
}

- (instancetype)initLayer{
    if (self = [super init]) {
        self.masksToBounds = YES;
    }
    return self;
}


- (void)drawInContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -bubbleHeight);
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, bubbleHeight, bubbleHeight), bubbleImage.CGImage);
    
    CGContextRestoreGState(ctx);
}

- (void)setImage:(UIImage *)image andHeight:(CGFloat)height {
    bubbleImage = image;
    bubbleHeight = height;
    self.bounds = CGRectMake(0, 0, height, height);
    self.cornerRadius = height/2;
    
//    //解决右上显示，但是可能会让变大动画看着不协调，动画是以锚点为中心的默认(.5,.5)
    self.anchorPoint = CGPointMake(1, 1);
    [self setNeedsDisplay];
}

#pragma mark - 添加
- (void)addToView:(UIView *)view {
    [view.layer addSublayer:self];
}



#pragma mark - 移动(设置时间间隔)
- (void)moveFrom:(CGPoint)from to:(CGPoint)to duration:(CGFloat)duration {
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //设置动画值
    animation.fromValue = [NSValue valueWithCGPoint:from];
    animation.toValue = [NSValue valueWithCGPoint:to];
    
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    self.position=[[animation valueForKey:@"KBubbleAnimationLocation"] CGPointValue];
    //提交事务
    [CATransaction commit];
    
    //设置其他属性
    animation.duration = duration;
    animation.delegate = self;
    //存储当前位置在动画结束后使用
    [animation setValue:[NSValue valueWithCGPoint:to] forKeyPath:@"KBubbleAnimationLocation"];

    //添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self addAnimation:animation forKey:@"KBubbleAnimation_Move"];
}

#pragma mark - 动画代理
- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"动画开始");
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}


#pragma mark - 变大消失
+ (void)biggerAndDismiss:(CALayer *)layer time:(CGFloat)time{
    CAKeyframeAnimation *keyBig = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    NSValue *key1=[NSValue valueWithCGRect:layer.bounds];
    NSValue *key2=[NSValue valueWithCGRect:CGRectMake(0, 0, layer.bounds.size.width + 15, layer.bounds.size.height + 15)];
    keyBig.values=@[key1,key2];
    //设置其他属性
    keyBig.duration = time;
    keyBig.beginTime = CACurrentMediaTime();
    [layer addAnimation:keyBig forKey:@"KCKeyBoundsAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.hidden = YES;
    });
}


@end
