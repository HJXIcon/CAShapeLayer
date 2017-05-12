//
//  CAShapeLayer+ViewMask.m
//  CAShapeLayer的练习
//
//  Created by mac on 17/4/22.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"


/*! UIBezierPath介绍
 
 ------  方法  ---------------
 
 // 创建基本路径
 + (instancetype)bezierPath;
 // 创建矩形路径
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 // 创建椭圆路径
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
 // 创建圆角矩形
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // rounds all corners with the same horizontal and vertical radius
 // 创建指定位置圆角的矩形路径
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 // 创建弧线路径
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
 // 通过CGPath创建
 + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
 
 
  ------  属性  ---------------
 
 // 与之对应的CGPath
 @property(nonatomic) CGPathRef CGPath;
 - (CGPathRef)CGPath NS_RETURNS_INNER_POINTER CF_RETURNS_NOT_RETAINED;
 
 // 是否为空
 @property(readonly,getter=isEmpty) BOOL empty;
 // 整个路径相对于原点的位置及宽高
 @property(nonatomic,readonly) CGRect bounds;
 // 当前画笔位置
 @property(nonatomic,readonly) CGPoint currentPoint;
 
 
 // 线宽
 @property(nonatomic) CGFloat lineWidth;
 
 // 终点类型
 @property(nonatomic) CGLineCap lineCapStyle;
 typedef CF_ENUM(int32_t, CGLineCap) {
 kCGLineCapButt,
 kCGLineCapRound,
 kCGLineCapSquare
 };
 
 // 交叉点的类型
 @property(nonatomic) CGLineJoin lineJoinStyle;
 typedef CF_ENUM(int32_t, CGLineJoin) {
 kCGLineJoinMiter,
 kCGLineJoinRound,
 kCGLineJoinBevel
 };
 
 // 两条线交汇处内角和外角之间的最大距离,需要交叉点类型为kCGLineJoinMiter是生效，最大限制为10
 @property(nonatomic) CGFloat miterLimit;
 // 个人理解为绘线的精细程度，默认为0.6，数值越大，需要处理的时间越长
 @property(nonatomic) CGFloat flatness;
 // 决定使用even-odd或者non-zero规则
 @property(nonatomic) BOOL usesEvenOddFillRule;
 
 
 ------ 对象方法 ------------
 // 反方向绘制path
 - (UIBezierPath *)bezierPathByReversingPath;
 
 // 设置画笔起始点
 - (void)moveToPoint:(CGPoint)point;
 
 // 从当前点到指定点绘制直线
 - (void)addLineToPoint:(CGPoint)point;
 
 // 添加弧线
 - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise NS_AVAILABLE_IOS(4_0);
 // center弧线圆心坐标 radius弧线半径 startAngle弧线起始角度 endAngle弧线结束角度 clockwise是否顺时针绘制
 
 // 添加贝塞尔曲线
 - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
 // endPoint终点 controlPoint控制点
 - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
 // endPoint终点 controlPoint1、controlPoint2控制点
 
 // 移除所有的点，删除所有的subPath
 - (void)removeAllPoints;
 
 // 将bezierPath添加到当前path
 - (void)appendPath:(UIBezierPath *)bezierPath;
 
 // 填充
 - (void)fill;
 
 // 路径绘制
 - (void)stroke;
 
 // 在这以后的图形绘制超出当前路径范围则不可见
 - (void)addClip;
 
 
 
 */

@implementation CAShapeLayer (ViewMask)
/*! 图解：
 http://www.jianshu.com/p/a1e88a277975
 */

+ (instancetype)createMaskLayerWithView : (UIView *)view{
    
    
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}
@end
