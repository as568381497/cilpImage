//
//  ViewController.h
//  ClipImage
//
//  Created by pathfinder on 2018/4/20.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBezierPath : UIBezierPath

@property (nonatomic, strong) UIColor *color;

//起点
@property (nonatomic, assign)CGPoint beganPoint;

- (NSArray *)points;

@end
