//
//  MyBezierPath.h
//  画板
//
//  Created by 杭城小刘 on 2018/1/2.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBezierPath : UIBezierPath

@property (nonatomic, strong) UIColor *color;

//起点
@property (nonatomic, assign)CGPoint beganPoint;



- (NSArray *)points;

@end
