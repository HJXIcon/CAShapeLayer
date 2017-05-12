//
//  CAShapeLayer+ViewMask.h
//  CAShapeLayer的练习
//
//  Created by mac on 17/4/22.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view;
@end
