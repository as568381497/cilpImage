//
//  ViewController.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/20.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#define OUTPUTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

#import "ViewController.h"
#import "DrawView.h"

@import CoreImage;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@property (weak, nonatomic)MyBezierPath *path;

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)cilpImage:(UIButton *)sender
{
    sender.hidden = YES;
    self.drawView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [self.drawView selectPathBlock:^(MyBezierPath *path) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        weakSelf.imageView = imageView;
        
        CALayer *contentLayer = [CALayer layer];
        [contentLayer setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = path.CGPath;
        
        [contentLayer setContents:(id)[[UIImage imageNamed:@"bg"] CGImage]];
        [contentLayer setMask:mask];
        
        [[imageView layer]addSublayer:contentLayer];
        weakSelf.path = path;
    }];
    
}


#pragma mark -- 获取图片
//以view生成图片
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//裁剪图片
- (UIImage *)clipImage:(UIImage *)viewImage WithRect:(CGRect)rect
{

    CGRect clipRect = CGRectMake(rect.origin.x * [UIScreen mainScreen].scale, rect.origin.y * [UIScreen mainScreen].scale, rect.size.width * [UIScreen mainScreen].scale, rect.size.height * [UIScreen mainScreen].scale);

    CGImageRef imageRef = viewImage.CGImage;

    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, clipRect);

    UIImage *sendImage =[[UIImage alloc] initWithCGImage:imageRefRect];

    return sendImage;
}

#pragma mark -- 计算裁剪位置位置

- (float)getImageWidth:(NSArray *)arr
{
    NSMutableArray *ArrX = [NSMutableArray array];
    for (NSValue *value in arr)
    {
        CGPoint point = [value CGPointValue];
        float pointX = point.x;
        NSNumber *number = [NSNumber numberWithFloat:pointX];
        [ArrX addObject:number];
    }
    
    CGFloat maxValue = [[ArrX valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[ArrX valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return maxValue - minValue;
}

- (float)getImageHeight:(NSArray *)arr
{
    NSMutableArray *ArrY = [NSMutableArray array];
    for (NSValue *value in arr)
    {
        CGPoint point = [value CGPointValue];
        float pointY = point.y;
        NSNumber *number = [NSNumber numberWithFloat:pointY];
        [ArrY addObject:number];
    }
    
    CGFloat maxValue = [[ArrY valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[ArrY valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return maxValue - minValue;
}

- (CGPoint)getImagePoint:(NSArray *)arr
{
    NSMutableArray *ArrY = [NSMutableArray array];
    NSMutableArray *ArrX = [NSMutableArray array];
    for (NSValue *value in arr)
    {
        CGPoint point = [value CGPointValue];
        
        float pointY = point.y;
        NSNumber *numberY = [NSNumber numberWithFloat:pointY];
        [ArrY addObject:numberY];
        
        float pointX = point.x;
        NSNumber *numberX = [NSNumber numberWithFloat:pointX];
        [ArrX addObject:numberX];
    }
    
    CGFloat minX = [[ArrX valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat minY = [[ArrY valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return CGPointMake(minX, minY);
}

@end
