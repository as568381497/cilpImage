//
//  ViewController.h
//  ClipImage
//
//  Created by pathfinder on 2018/4/20.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBezierPath.h"

@interface DrawView : UIView

@property (nonatomic, strong) UIImage *image;

#pragma mark - 返回路径

- (void)selectPathBlock:(void(^)(MyBezierPath *path))path;

@end
