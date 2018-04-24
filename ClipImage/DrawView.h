//
//  DrawView.h
//  画板
//
//  Created by 杭城小刘 on 2017/12/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBezierPath.h"

@interface DrawView : UIView

@property (nonatomic, strong) UIImage *image;

//清屏
-(void)clearScreen;

//撤销
-(void)revoke;

//橡皮擦
-(void)erease;

//设置颜色
-(void)setPenColor:(UIColor *)color;

//设置线条宽度
-(void)setPenWidth:(CGFloat)width;

#pragma mark - 返回路径

- (void)selectPathBlock:(void(^)(MyBezierPath *path))path;

@end
