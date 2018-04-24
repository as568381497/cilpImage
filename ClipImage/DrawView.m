

//
//  DrawView.m
//  画板
//
//  Created by 杭城小刘 on 2017/12/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "DrawView.h"



@interface DrawView()

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) MyBezierPath *path;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGPoint previousPoint;
@property (nonatomic, assign) CGPoint firstPoint;
@end

@implementation DrawView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.image = [UIImage imageNamed:@"bg"];
    
    self.lineColor = [UIColor whiteColor];
    self.lineWidth = 5;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGesture];
}

-(void)panAction:(UITapGestureRecognizer *)gesture{
    
    CGPoint currentPoint = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        MyBezierPath *path = [MyBezierPath bezierPath];
        self.path = path;
        [self.paths addObject:self.path];
    
        path.color = self.lineColor;
        
        [self.path setLineWidth:self.lineWidth];
        
        [self.path moveToPoint:currentPoint];
        NSLog(@"起点%f--%f",currentPoint.x,currentPoint.y);
        self.path.beganPoint = currentPoint;
        self.previousPoint = self.firstPoint =  currentPoint;
        
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        
        CGPoint midPoint = midpoint(self.previousPoint,currentPoint);
        [self.path addQuadCurveToPoint:midPoint controlPoint:self.previousPoint];
        self.previousPoint = currentPoint;
        [self setNeedsDisplay];
         NSLog(@"线%f--%f",currentPoint.x,currentPoint.y);
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint midPoint = midpoint(self.firstPoint,currentPoint);
        if ([self distancePointA:currentPoint PointB:midPoint] < 20)
        {
            [self.path closePath];
            [self setNeedsDisplay];
            
        }
    }
    
}


- (float)distancePointA:(CGPoint)p1 PointB:(CGPoint)p2
{
    //pow求次方 sqrt开次方
    return sqrtf(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2));
}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint)
    {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}


- (void)selectPathBlock:(void (^)(MyBezierPath *))path
{
    if (self.path)
    {
        path(self.path);
    }
}


-(void)drawRect:(CGRect)rect{
    //取出所有的路径来画线
    for (MyBezierPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
        
    }
}

#pragma mark -- setter

-(void)setImage:(UIImage *)image{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

#pragma mark -- public method

//清屏
-(void)clearScreen{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
    
}

//撤销
-(void)revoke{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

//橡皮擦
-(void)erease{
    self.lineColor = [UIColor whiteColor];
}

//设置颜色
-(void)setPenColor:(UIColor *)color{
    self.lineColor = color;
    [self setNeedsDisplay];
}

//设置线条宽度
-(void)setPenWidth:(CGFloat)width{
    self.lineWidth = width;
    [self setNeedsDisplay];
}

#pragma mark -- lazy load

-(NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

-(MyBezierPath *)path{
    if (!_path) {
        _path = [MyBezierPath bezierPath];
    }
    return _path;
}


@end
