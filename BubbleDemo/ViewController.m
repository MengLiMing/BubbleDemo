//
//  ViewController.m
//  BubbleDemo
//
//  Created by my on 16/7/23.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ViewController.h"
#import "BubbleLayer.h"
#import "RandomHelp.h"

@interface ViewController () {
    NSArray *imageArray;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    [self createBubble];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(createBubble) userInfo:nil repeats:YES];
    
    [self addGesture];
}

#pragma mark - 手势
- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tapGesture {
    CGPoint touch = [tapGesture locationInView:self.view];

    for (CALayer *bubble in self.view.layer.sublayers) {
        if ([bubble isKindOfClass:[BubbleLayer class]]) {
            if ([bubble.presentationLayer hitTest:touch]) {
                [BubbleLayer biggerAndDismiss:bubble time:.5];
            }
        }
    }

}


- (void)createBubble {
    for (NSInteger i = 0; i < 2; i++) {
        BubbleLayer *layer = [[BubbleLayer alloc] initWithPosition:self.view.center];
        [layer setImage:[self bubbleImage] andHeight:80];
        [layer addToView:self.view];
        
        CGPoint from = [self startPoint];
        CGPoint to = CGPointMake(from.x, -80);
        [layer moveFrom:from to:to duration:[self animationDuration]];
    }
}


//随机产生point
- (CGPoint)startPoint {
    return CGPointMake([RandomHelp randomFloatBetween:80 and:self.view.frame.size.width], self.view.frame.size.height + 80);
}

//随机产生动画的间隔时间
- (CGFloat)animationDuration {
    return [RandomHelp randomFloatBetween:6 and:12];
}

//随机生成图片
- (UIImage *)bubbleImage {
    return [UIImage imageNamed:imageArray[arc4random() % imageArray.count]];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
