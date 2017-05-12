//
//  JXCircleProgressView.m
//  CAShapeLayer的练习
//
//  Created by mac on 17/4/22.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCircleProgressView.h"


static  CGFloat const kLineWidth = 2.0;
@implementation JXCircleProgressView


- (void)drawRect:(CGRect)rect {
    
    
    self.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = kLineWidth;
    
    [[UIColor redColor] set];
    
    //拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - kLineWidth) * 0.5;
    
    CGPoint center = (CGPoint){rect.size.width * 0.5, rect.size.height * 0.5};
    
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:2 * M_PI * _progress clockwise:YES];
    
    // 连线
    [path stroke];
    
    
    
    NSString *string = [NSString stringWithFormat:@"%d%%", (int)floor(_progress * 100)];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    // 计算文字宽高使文字在中间
    CGSize size = [string sizeWithAttributes:dict];
    
    CGPoint textPoint = CGPointMake(center.x - size.width * 0.5, center.y - size.height* 0.5);
    
    [string drawAtPoint:textPoint withAttributes:dict];
    
    NSLog(@"string == %@",string);
    
}




- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
}







@end
