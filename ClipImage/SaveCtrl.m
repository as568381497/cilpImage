//
//  SaveCtrl.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/24.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import "SaveCtrl.h"
#import "GifUtils.h"

@interface SaveCtrl ()


//display
@property (strong, nonatomic)UIImageView *imageView;

@property (strong, nonatomic)UIImageView *imageViewOne;
@property (strong, nonatomic)UIImageView *imageViewTwo;

@property (retain, nonatomic)NSMutableArray *data;


@property (retain, nonatomic)NSMutableArray *images;


@property (assign, nonatomic)NSUInteger conut;

@end

@implementation SaveCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [NSMutableArray array];
    self.conut = 0;
    
    self.imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 100, 100)];
    self.imageViewOne.image = self.image;
    self.imageViewOne.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageViewOne];
    
    self.imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-100, 100, 100)];
    self.imageViewTwo.image = self.image;
    self.imageViewTwo.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageViewTwo];
    
}

- (IBAction)mackGif:(UIButton *)sender
{
//    [self.data removeAllObjects];
//    for (int i = 0; i<96; i++)
//    {
//
//        [self.data addObject:[GifUtils makeImageWithView:self.imageView withSize:self.view.frame.size]];
//        NSLog(@"数量是：%ld",self.data.count);
//    }
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
//    self.imageView = imageView;
//    self.imageView.backgroundColor = [UIColor redColor];
//    UIImage *image = [self.data firstObject];
//    imageView.image = image;
//    imageView.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:imageView];
//    self.conut++;
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(repeat:) userInfo:@{@"key":@"value"} repeats:true];
        [[NSRunLoop currentRunLoop] run];
        
    });
    
}




- (void)repeat:(NSTimer *)timer
{
     __weak typeof(self) weakSelf = self;
    if (self.conut == 30)
    {
        [timer invalidate];
        NSLog(@"取值完成");
        self.conut = 0;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageViewTwo.layer removeAllAnimations];
            [weakSelf.imageViewOne.layer removeAllAnimations];
        });
        
        return;
    }
    
   

    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGRect rectOne = weakSelf.imageViewOne.layer.presentationLayer.frame;
        NSValue *valueOne = [NSValue valueWithCGRect:rectOne];
        
        CGRect rectTwo = weakSelf.imageViewTwo.layer.presentationLayer.frame;
        NSValue *valueTwo = [NSValue valueWithCGRect:rectTwo];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:valueOne,@"one",valueTwo,@"two", nil];
        
        [weakSelf.data addObject:dic];
        weakSelf.conut++;
    });
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.images.count == 0)
    {
        return;
    }
    
    UIImage *image = [self.images objectAtIndex:self.conut];
    self.imageView.image = image;
    self.conut++;
    
    
}

- (IBAction)animation:(UIButton *)sender
{
    
    CALayer *viewLayer = [self.imageViewOne layer];
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x-100, position.y);
    CGPoint y = CGPointMake(position.x+100, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    animation.duration = 1;//持续时间
    animation.repeatCount = HUGE_VALF;//抖动次数
    animation.autoreverses = YES;//反极性
    [viewLayer addAnimation:animation forKey:nil];
    
    CALayer *viewLayerTwo = [self.imageViewTwo layer];
    CGPoint positionTwo = viewLayerTwo.position;
    CGPoint x2 = CGPointMake(positionTwo.x+100, positionTwo.y);
    CGPoint y2 = CGPointMake(positionTwo.x-100, positionTwo.y);
    CABasicAnimation *animationTwo = [CABasicAnimation animationWithKeyPath:@"position"];
    [animationTwo setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animationTwo setFromValue:[NSValue valueWithCGPoint:x2]];
    [animationTwo setToValue:[NSValue valueWithCGPoint:y2]];
    animationTwo.duration = 1;//持续时间
    animationTwo.repeatCount = HUGE_VALF;//抖动次数
    animationTwo.autoreverses = YES;//反极性
    [viewLayerTwo addAnimation:animationTwo forKey:nil];
    
}

- (IBAction)mack:(UIButton *)sender
{
    self.images = [NSMutableArray array];
    UIView *makeView = [[UIView alloc] initWithFrame:self.view.frame];
    UIImageView *mackImageOne = [[UIImageView alloc] init];
    mackImageOne.image = self.image;
    [makeView addSubview:mackImageOne];
    
    UIImageView *mackImageTwo = [[UIImageView alloc] init];
    mackImageTwo.image = self.image;
    [makeView addSubview:mackImageTwo];
    
    for (NSDictionary *dic in self.data)
    {
        NSValue *valueOne = [dic objectForKey:@"one"];
        CGRect rectOne = [valueOne CGRectValue];
        
        NSValue *valueTwo = [dic objectForKey:@"two"];
        CGRect rectTwo = [valueTwo CGRectValue];
        
        mackImageOne.frame = rectOne;
        mackImageTwo.frame = rectTwo;
        
        UIImage *image = [GifUtils makeImageWithView:makeView withSize:self.view.frame.size];
        [self.images addObject:image];
        NSLog(@"存入数量：%ld",self.images.count);
    }
    
    
    self.imageViewTwo.hidden =  self.imageViewOne.hidden = YES;
    
    self.imageView = [[UIImageView alloc] init];
     self.imageView.frame = self.view.frame;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageView];
    
}




@end
