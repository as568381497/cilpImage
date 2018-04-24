//
//  MyBezierPath.m
//  画板
//
//  Created by 杭城小刘 on 2018/1/2.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "MyBezierPath.h"

#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]

@implementation MyBezierPath

void getPointsFromBezier(void *info,const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:VALUE(0)];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:VALUE(2)];
    }
    
}

- (NSArray *)points
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points;
    
}



@end
