//
//  ViewController.m
//  Bubble
//
//  Created by Ryan on 16/5/13.
//  Copyright © 2016年 monkey. All rights reserved.
//

#import "ViewController.h"

#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth ([[UIScreen mainScreen] bounds].size.width)

@interface ViewController ()
/** 朋友 */
@property (nonatomic, weak) UIButton  *friendBtn;
/** 游戏 */
@property (nonatomic, weak) UIButton  *gameBtn;
/** 赞 */
@property (nonatomic, weak) UIButton  *thingBtn;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *friendBtn = [[UIButton alloc] init];
    [friendBtn setBackgroundImage: [UIImage imageNamed:@"Bubble_yellow"] forState:UIControlStateNormal];
    [friendBtn setTitle:@"好友" forState:UIControlStateNormal];
    [self.view addSubview:friendBtn];
    self.friendBtn = friendBtn;
    
    
    UIButton *thingBtn = [[UIButton alloc] init];
    [thingBtn setBackgroundImage: [UIImage imageNamed:@"Bubble_green"] forState:UIControlStateNormal];
    [thingBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.view addSubview:thingBtn];
    self.thingBtn = thingBtn;
    
    
    UIButton *gameBtn = [[UIButton alloc] init];
    [gameBtn setBackgroundImage: [UIImage imageNamed:@"Bubble_red"] forState:UIControlStateNormal];
    [gameBtn setTitle:@"游戏" forState:UIControlStateNormal];
    [self.view addSubview:gameBtn];
    self.gameBtn = gameBtn;

    
    
    [self addEnterAnimation];
}


/**
 *  添加进入的动画
 */
- (void)addEnterAnimation {
// 初始化位置
    self.friendBtn.frame = CGRectMake(-90, 400, 90, 90);
    self.gameBtn.frame = CGRectMake(120, UIScreenHeight + 120, 120, 120);
    self.thingBtn.frame = CGRectMake(UIScreenWidth + 90, 400, 90, 90);
    
    [self addMoveAnimation:self.friendBtn toPoint:CGPointMake(75, 400 + 45)];
    [self addMoveAnimation:self.gameBtn toPoint:CGPointMake(180, 400 + 60)];
    [self addMoveAnimation:self.thingBtn toPoint:CGPointMake(285, 400 + 45)];
    
    [self performSelector:@selector(moveDidFinish) withObject:nil afterDelay:2.0];
}

/**
 *  添加移动动画
 */
- (void)addMoveAnimation:(UIView *)mView toPoint:(CGPoint)toPoint {

    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:mView.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    moveAnimation.repeatCount = 1;
    moveAnimation.duration = 2.0;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [mView.layer addAnimation:moveAnimation forKey:@"move"];
    
}

/**
 *  进入动画结束
 */
- (void)moveDidFinish {
    // 设置fream
    self.friendBtn.frame = CGRectMake(30, 400, 90, 90);
    self.thingBtn.frame = CGRectMake(240, 400, 90, 90);
    self.gameBtn.frame = CGRectMake(120, 400, 120, 120);
    [self RemoveAllAnimation];
    
    
    
    [self addFloatAnimationWithView:self.thingBtn];
    [self addFloatAnimationWithView:self.friendBtn];
    [self addFloatAnimationWithView:self.gameBtn];
}

/**
 *  移除所有动画
 */
- (void)RemoveAllAnimation {
    [self.friendBtn.layer removeAllAnimations];
    [self.thingBtn.layer removeAllAnimations];
    [self.gameBtn.layer removeAllAnimations];
}

/**
 *  浮动动画
 */
- (void)addFloatAnimationWithView:(UIView *)mView {
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.repeatCount = MAXFLOAT;
    pathAnimation.duration = 9.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; // 线性
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect circle = CGRectInset(mView.frame, mView.bounds.size.width/ 2- 3, mView.bounds.size.width/2 - 3);
    CGPathAddEllipseInRect(path, NULL, circle);
    pathAnimation.path = path;
//    但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CGPathRelease(path);
    [mView.layer addAnimation:pathAnimation forKey:@"Circle"];
    

    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 4.0;
    scaleX.values = @[@1.0, @1.1, @1.0];
    scaleX.repeatCount = MAXFLOAT;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 4.0;
    scaleY.values = @[@1.0, @1.1, @1.0];
    scaleY.repeatCount = MAXFLOAT;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 4.0;
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.animations = @[scaleX, scaleY];
    
    [mView.layer addAnimation:groupAnimation forKey:@"FloatAnimation"];
}
@end
