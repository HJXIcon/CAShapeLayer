//
//  JXCircleProgressView2.h
//  CAShapeLayer的练习
//
//  Created by mac on 17/5/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JXCircleProgressView2 : UIView{
    CAShapeLayer *_shapeLayer;
}


/**起始值（0-1）*/
@property(nonatomic,assign)CGFloat fstartValue;

/**边框宽度*/
@property(nonatomic,assign)CGFloat flineWidth;

/**线条颜色*/
@property(nonatomic,strong)UIColor *lineColor;

/**变化的值*/
@property(nonatomic,assign)CGFloat fvalue;


@end
