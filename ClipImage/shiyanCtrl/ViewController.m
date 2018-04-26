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
#import "SaveCtrl.h"
#import "StaticCtrl.h"
#import "DynamicCtrl.h"

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
    
    if (self.imageView)
    {
        NSArray *arr = [self.path points];
        float width = [self getImageWidth:arr];
        float height = [self getImageHeight:arr];
        CGPoint point = [self getImagePoint:arr];
        CGRect rect = CGRectMake(point.x, point.y, width, height);

        UIImage *image = [self makeImageWithView:self.imageView withSize:self.view.frame.size];
        UIImage *imageEnd = [self clipImage:image WithRect:rect];
        
        SaveCtrl *ctel = [STORYBOARD instantiateViewControllerWithIdentifier:NSStringFromClass([SaveCtrl class])];
        ctel.image = imageEnd;
        [self showViewController:ctel sender:nil];
        
    }
    else
    {
        self.drawView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [sender setTitle:@"跳转" forState:UIControlStateNormal];
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

//生成图片文件
- (void)clipScreenWithPath:(NSString *)path type:(NSString *)type UIView:(UIView *)view

{
    
    //1.开启一个和传进来的View大小一样的位图上下文
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,0);
    
    //2.把控制器的View绘制到上下文当中
    
    //想把UIView上面的东西绘制到上下文当中,必须得使用渲染的方式
    
    //renderInContext:就是渲染的方式
    
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx ];
    
    //3从上下文当中生成一张图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4.关闭上下文
    
    UIGraphicsEndImageContext();
    
    //5.把生成的图片写入到桌面(以文件的方式进行传输:二进制流NSData,即把图片转为二进制流)
    
    NSData *data;
    
    if ([type isEqualToString:@"png"]) {
        
        //生成PNG格式的图片
        
        data = UIImagePNGRepresentation(newImage);
        NSLog(@"生成成功.png");
        
    }
    
    else if ([type isEqualToString:@"jpg"]){
        
        //5.1把图片转为二进制流(第一个参数是图片,第2个参数是图片压缩质量:1是最原始的质量)
        
        data = UIImageJPEGRepresentation(newImage,1);
        NSLog(@"生成成功.jpg");
        
    }
    
    [data writeToFile:path atomically:YES];
    
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

#pragma mark --

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
