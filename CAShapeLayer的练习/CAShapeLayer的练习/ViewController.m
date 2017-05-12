//
//  ViewController.m
//  CAShapeLayer的练习
//
//  Created by mac on 17/4/22.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"
#import "JXCircleProgressView.h"
#import "JXCircleProgressView2.h"


static CGFloat timeValue = 0 ;
@interface ViewController ()<CAAnimationDelegate>


@property(nonatomic, strong) NSTimer *timer ;

@property(nonatomic, weak) JXCircleProgressView *circleView;
@property(nonatomic, strong) JXCircleProgressView2 *circleView2;

@end

@implementation ViewController
/*!
 1、CAShapeLayer继承自CALayer，可以使用CALayer的所有属性值
 2、CAShapeLayer需要与贝塞尔曲线配合使用才有意义
 3、使用CAShapeLayer与贝塞尔曲线可以实现不在view的drawRect方法中画出有一些想要的图形
 4、CAShapeLayer属于CoreAnimation框架，其动画渲染直接提交到手机的GPU当中，相较于view的drawRect方法使用CPU渲染而言，其效率极高，能大大优化内存使用情况。
 个人经验：可以重写UIView的子类中的drawRect来实现进度条效果，但是UIView的drawRect是用CPU渲染实现的，而使用CAShapeLayer效率更高，因为它用的是GPU渲染。
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self drawRadiu];
    
//    [self drawProgress];
    
//    [self drawProgressAnimation2];
    
//    [self drawChatBg];
//    return;
    
    //圆圈
    JXCircleProgressView *circleView = [[JXCircleProgressView alloc] initWithFrame:CGRectMake(50, 100, 150, 150)];
   
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
    [self addTimer];
    
}


- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction{
    self.circleView.progress += 0.01;
    
    if (self.circleView.progress > 1) {
        [_timer invalidate];
        _timer = nil;
    }
}


/// 进度条(无动画)
- (void)drawProgress{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(50, 100, 100, 100);
    shapeLayer.strokeEnd = 0.7f;
    shapeLayer.strokeStart = 0.1f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 100, 100)];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
    
    
}

- (void)drawProgressAnimation2{
    _circleView2 = [[JXCircleProgressView2 alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    _circleView2.center      = self.view.center;
    _circleView2.lineColor   = [UIColor redColor];
    _circleView2.flineWidth  = 1.0f;
    _circleView2.fstartValue = 0;
    [self.view addSubview:_circleView2];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(circleAnimation)userInfo:nil repeats:YES];
    
}

- (void)circleAnimation
{
    timeValue += 0.1;
    _circleView2.fvalue = timeValue ;
}



/// 进度条(动画)
- (void)drawProgressAnimation{
    
  
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(50, 100, 100, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 100, 100)];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnima.duration = 3.0;
    
    /*!
     Timing Function的会被用于变化起点和终点之间的插值计算.形象点说是Timing Function决定了动画运行的节奏(Pacing),比如是均匀变化(相同时间变化量相同),先快后慢,先慢后快还是先慢再快再慢.
     */
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
   
    
}



// 聊天背景
- (void)drawChatBg{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 50, 120, 30)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:view];
    view.layer.mask = layer;
}


/// 画圆
- (void)drawRadiu{
    // 内圆半径
    CGFloat innerWhiteRadius = 20;
    
    CGFloat currentRadian = -M_PI/2;
    
    NSArray *values = @[@"2",@"3",@"5",@"9"];
    
    
    NSArray *colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor blueColor],[UIColor orangeColor]];
    
    CGFloat totalValue = 0;
    
    for (NSString *valueString in values) {
        
        totalValue += [valueString floatValue];
    }
    
    for (int i = 0 ; i < colors.count; i ++) {
        
        
        CGFloat radian = [self loadPercentRadianWithCurrent:[values[i] floatValue] withTotalValue:totalValue];
        
        
        CGFloat endAngle = currentRadian + radian;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:self.view.center];
        
        //圆弧 默认最右端为0，YES时为顺时针。NO时为逆时针
        [path addArcWithCenter:self.view.center radius:100 startAngle:currentRadian endAngle:endAngle clockwise:YES];
        
        // 内圆
        [path addArcWithCenter:self.view.center radius:innerWhiteRadius startAngle:endAngle endAngle:currentRadian clockwise:NO];
        
        //添加到圆心直线
        [path addLineToPoint:self.view.center];
        
        //路径闭合
        [path closePath];
        
        
        //初始化Layer
        CAShapeLayer *radiusLayer = [CAShapeLayer layer];
        //设置layer的路径
        radiusLayer.path = path.CGPath;
        UIColor *color = colors[i];
        radiusLayer.fillColor = color.CGColor;
        
        [self.view.layer addSublayer:radiusLayer];
        
        //下一个弧度开始位置为当前弧度的结束位置
        currentRadian = endAngle;
        
    }
    
}


- (CGFloat)loadPercentRadianWithCurrent:(CGFloat)current withTotalValue:(CGFloat)total
{
    CGFloat percent = current/total;
    
    return percent*M_PI*2;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
