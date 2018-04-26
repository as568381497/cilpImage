//
//  ShowImageCtrl.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/26.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import "ShowImageCtrl.h"

#define IMAGEWIDTH self.view.frame.size.width/12
#define IMAGEHEIGHT self.view.frame.size.height/15

@interface ShowImageCtrl ()

@property (retain,nonatomic)NSMutableArray *imageViews;


@end

@implementation ShowImageCtrl



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.imageViews = [NSMutableArray array];
    
    switch (self.type)
    {
        case showOne:
        {
            [self showOne];
        }
        break;
            
        case showTwo:
        {
            [self showTwo];
        }
            break;
            
        case showThree:
        {
            [self showThree];
        }
            break;
            
        case showFour:
        {
            [self showFour];
        }
            break;
            
        case showFive:
        {
            [self showFive];
        }
            break;
            
        case showSix:
        {
            [self showSix];
        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
    
    
}

- (IBAction)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---

- (void)showOne
{
    NSInteger y = 0;
    NSInteger x = 0;
    for (int i = 0; i < 48; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgee"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        imageView.frame = CGRectMake(x*IMAGEWIDTH, y*IMAGEHEIGHT, IMAGEWIDTH, IMAGEHEIGHT);
        
        x++;
        
        if ((i+1) % 12 == 0)
        {
            y ++;
        }
        
        if (x>11)
        {
            x = 0;
        }
        imageView.tag = i;
        [self.imageViews addObject:imageView];
    }
}

- (void)showTwo
{
    
    NSInteger y = 0;
    NSInteger x = 0;
    
    float line = IMAGEWIDTH/2;
    
    
    for (int i = 0; i < 48; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgee"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        if ((y+1)%2 == 0)
        {
            imageView.frame = CGRectMake(x*IMAGEWIDTH+line*x + line*1.5, IMAGEHEIGHT*y, IMAGEWIDTH, IMAGEHEIGHT);
        }
        else
        {
            imageView.frame = CGRectMake(x*IMAGEWIDTH+line*x, IMAGEHEIGHT*y, IMAGEWIDTH, IMAGEHEIGHT);
        }
        
        
        x++;
        
        if ((i+1) % 8 == 0)
        {
            y ++;
        }
        
        if ( x>7 )
        {
            x = 0;
        }
        
        [self.imageViews addObject:imageView];
        imageView.tag = i;
    }
    
    
}

- (void)showThree
{
    NSInteger y = 0;
    NSInteger x = 0;
    
    float line = IMAGEHEIGHT/2;
    
    
    for (int i = 0; i < 40; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgee"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        
        
        if ((x+1)%2 == 0)
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x, IMAGEHEIGHT*y+line*y+line*1.5, IMAGEWIDTH, IMAGEHEIGHT);
        }
        else
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x, IMAGEHEIGHT*y+line*y, IMAGEWIDTH, IMAGEHEIGHT);
        }
        
        
        y++;
        
        if ((i+1) % 10 == 0)
        {
            x ++;
        }

        if ( y>9 )
        {
            y = 0;
        }
        
        [self.imageViews addObject:imageView];
        imageView.tag = i;
    }
    
}

- (void)showFour
{
    NSInteger y = 0;
    NSInteger x = 0;
    
    float line = IMAGEHEIGHT/2;
    
    
    for (int i = 0; i < 40; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgee"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        [self.view addSubview:imageView];
        
        
        if ((x+1)%2 == 0)
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x, IMAGEHEIGHT*y+line*y+line*1.5, IMAGEWIDTH, IMAGEHEIGHT);
            imageView.transform = CGAffineTransformMakeRotation(-M_PI);
        }
        else
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x, IMAGEHEIGHT*y+line*y, IMAGEWIDTH, IMAGEHEIGHT);
        }
        
        
        y++;
        
        if ((i+1) % 10 == 0)
        {
            x ++;
        }
        
        if ( y>9 )
        {
            y = 0;
        }
        imageView.tag = i;
        [self.imageViews addObject:imageView];
    }
}

- (void)showFive
{
    NSInteger y = 0;
    NSInteger x = 0;
    
    float line = IMAGEHEIGHT/2;
    
    
    for (int i = 0; i < 40; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tab_play"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        
        if ((x+1)%2 == 0)
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x+5*x, IMAGEHEIGHT*y+line*y+line*1.5, IMAGEWIDTH, IMAGEHEIGHT);
            imageView.layer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
        }
        else
        {
            imageView.frame = CGRectMake(IMAGEWIDTH*x+5*x, IMAGEHEIGHT*y+line*y, IMAGEWIDTH, IMAGEHEIGHT);
        }
        
        
        y++;
        
        if ((i+1) % 10 == 0)
        {
            x ++;
        }
        
        if ( y>9 )
        {
            y = 0;
        }
        [self.imageViews addObject:imageView];
    }
}

- (void)showSix
{
    NSInteger y = 0;
    NSInteger x = 0;
    
    float line = IMAGEWIDTH/2;
    
    
    for (int i = 0; i < 48; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgee"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:imageView];
        if ((y+1)%2 == 0)
        {
            imageView.frame = CGRectMake(x*IMAGEWIDTH+line*x + line*1.5, IMAGEHEIGHT*y, IMAGEWIDTH, IMAGEHEIGHT);
            imageView.transform = CGAffineTransformMakeRotation(-M_PI_4);
        }
        else
        {
            imageView.frame = CGRectMake(x*IMAGEWIDTH+line*x, IMAGEHEIGHT*y, IMAGEWIDTH, IMAGEHEIGHT);
            imageView.transform = CGAffineTransformMakeRotation(M_PI_4);
        }
        
        
        x++;
        
        if ((i+1) % 8 == 0)
        {
            y ++;
        }
        
        if ( x>7 )
        {
            x = 0;
        }
       
    }
}

#pragma mark --- animate

- (IBAction)ImangeAnimate:(UIButton *)sender
{
    switch (self.type)
    {
        case showOne:
        {
            for (UIImageView *imageView in self.imageViews)
            {
                
                CALayer *viewLayer = [imageView layer];
                CGPoint position = viewLayer.position;
                CGPoint x;
                CGPoint y;
                
                NSInteger i = (imageView.tag)/12;
                
                if (i%2 == 0)
                {
                    x = CGPointMake(position.x-150, position.y);
                    y = CGPointMake(position.x+150, position.y);
                }
                else
                {
                    x = CGPointMake(position.x+150, position.y);
                    y = CGPointMake(position.x-150, position.y);
                }
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setFromValue:[NSValue valueWithCGPoint:x]];
                [animation setToValue:[NSValue valueWithCGPoint:y]];
                animation.duration = 8;//持续时间
                animation.repeatCount = HUGE_VALF;//抖动次数
                animation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animation forKey:nil];
                
                CABasicAnimation *animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                [animationRotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                animationRotation.fromValue = [NSNumber numberWithFloat:-M_1_PI*0.1]; // 起始角度
                animationRotation.toValue = [NSNumber numberWithFloat:M_1_PI*0.1]; // 终止角度
                animationRotation.duration = 0.1;//持续时间
                animationRotation.repeatCount = HUGE_VALF;//抖动次数
                animationRotation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animationRotation forKey:nil];
                
                
            }
        }
            break;
            
        case showTwo:
        {
            for (UIImageView *imageView in self.imageViews)
            {
                
                CALayer *viewLayer = [imageView layer];
                CGPoint position = viewLayer.position;
                CGPoint x;
                CGPoint y;
                
                NSInteger i = (imageView.tag)/8;
                
                if (i%2 == 0)
                {
                    x = CGPointMake(position.x-150, position.y);
                    y = CGPointMake(position.x+150, position.y);
                }
                else
                {
                    x = CGPointMake(position.x+150, position.y);
                    y = CGPointMake(position.x-150, position.y);
                }
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setFromValue:[NSValue valueWithCGPoint:x]];
                [animation setToValue:[NSValue valueWithCGPoint:y]];
                animation.duration = 8;//持续时间
                animation.repeatCount = HUGE_VALF;//抖动次数
                animation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animation forKey:nil];
                
                CABasicAnimation *animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                [animationRotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                animationRotation.fromValue = [NSNumber numberWithFloat:-M_1_PI*0.1]; // 起始角度
                animationRotation.toValue = [NSNumber numberWithFloat:M_1_PI*0.1]; // 终止角度
                animationRotation.duration = 0.1;//持续时间
                animationRotation.repeatCount = HUGE_VALF;//抖动次数
                animationRotation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animationRotation forKey:nil];
                
                
            }
        }
            break;
            
        case showThree:
        {
            for (UIImageView *imageView in self.imageViews)
            {
                
                
                CALayer *viewLayer = [imageView layer];
                CGPoint position = viewLayer.position;
                CGPoint x;
                CGPoint y;
                
                NSInteger i = imageView.tag/10;
                
                if ((i+1)%2 == 0)
                {
                    x = CGPointMake(position.x, position.y-150);
                    y = CGPointMake(position.x, position.y+150);
                }
                else
                {
                    x = CGPointMake(position.x, position.y+150);
                    y = CGPointMake(position.x, position.y-150);
                }
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setFromValue:[NSValue valueWithCGPoint:x]];
                [animation setToValue:[NSValue valueWithCGPoint:y]];
                animation.duration = 8;//持续时间
                animation.repeatCount = HUGE_VALF;//抖动次数
                animation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animation forKey:nil];
                
                CABasicAnimation *animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                [animationRotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                animationRotation.fromValue = [NSNumber numberWithFloat:-M_1_PI*0.1]; // 起始角度
                animationRotation.toValue = [NSNumber numberWithFloat:M_1_PI*0.1]; // 终止角度
                animationRotation.duration = 0.1;//持续时间
                animationRotation.repeatCount = HUGE_VALF;//抖动次数
                animationRotation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animationRotation forKey:nil];
                
                
            }
        }
            break;
            
        case showFour:
        {
            
            for (UIImageView *imageView in self.imageViews)
            {
            

                CALayer *viewLayer = [imageView layer];
                CGPoint position = viewLayer.position;
                CGPoint x;
                CGPoint y;
                
                NSInteger i = imageView.tag/10;
                
                if ((i+1)%2 == 0)
                {
                    x = CGPointMake(position.x, position.y-150);
                    y = CGPointMake(position.x, position.y+150);
                }
                else
                {
                    x = CGPointMake(position.x, position.y+150);
                    y = CGPointMake(position.x, position.y-150);
                }
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setFromValue:[NSValue valueWithCGPoint:x]];
                [animation setToValue:[NSValue valueWithCGPoint:y]];
                animation.duration = 8;//持续时间
                animation.repeatCount = HUGE_VALF;//抖动次数
                animation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animation forKey:nil];
                
                CABasicAnimation *animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                [animationRotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                animationRotation.fromValue = [NSNumber numberWithFloat:-M_1_PI*0.1]; // 起始角度
                animationRotation.toValue = [NSNumber numberWithFloat:M_1_PI*0.1]; // 终止角度
                animationRotation.duration = 0.1;//持续时间
                animationRotation.repeatCount = HUGE_VALF;//抖动次数
                animationRotation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animationRotation forKey:nil];
                
                
            }
            
        }
            break;
            
        case showFive:
        {
            for (UIImageView *imageView in self.imageViews)
            {
                
                
                CALayer *viewLayer = [imageView layer];
                CGPoint position = viewLayer.position;
                CGPoint x;
                CGPoint y;
                
                NSInteger i = imageView.tag/10;
                
                if ((i+1)%2 == 0)
                {
                    x = CGPointMake(position.x, position.y-150);
                    y = CGPointMake(position.x, position.y+150);
                }
                else
                {
                    x = CGPointMake(position.x, position.y+150);
                    y = CGPointMake(position.x, position.y-150);
                }
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setFromValue:[NSValue valueWithCGPoint:x]];
                [animation setToValue:[NSValue valueWithCGPoint:y]];
                animation.duration = 8;//持续时间
                animation.repeatCount = HUGE_VALF;//抖动次数
                animation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animation forKey:nil];
                
                CABasicAnimation *animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                [animationRotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                animationRotation.fromValue = [NSNumber numberWithFloat:-M_1_PI*0.1]; // 起始角度
                animationRotation.toValue = [NSNumber numberWithFloat:M_1_PI*0.1]; // 终止角度
                animationRotation.duration = 0.1;//持续时间
                animationRotation.repeatCount = HUGE_VALF;//抖动次数
                animationRotation.autoreverses = YES;//反极性
                [viewLayer addAnimation:animationRotation forKey:nil];
                
                
            }
        }
            break;
            
        case showSix:
        {
            
        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
}

@end
