//
//  StaticCtrl.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/25.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import "StaticCtrl.h"




@interface StaticCtrl ()
@property (weak, nonatomic) IBOutlet UIView *conterView;

@end

@implementation StaticCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)shengcheng:(UIButton *)sender
{
    CGFloat width = self.conterView.frame.size.width/3;
    CGFloat height = self.conterView.frame.size.height/5;
    NSInteger y = 0;
    NSInteger x = 0;
    for (int i = 0; i < 15; i++)
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.conterView addSubview:imageView];
        imageView.frame = CGRectMake(x*width, y*height, width, height);
        x++;
        
        if ((i+1) % 3 == 0)
        {
            y ++;
        }
        
        if (x>2)
        {
            x = 0;
        }
    }
}

- (IBAction)saveImage:(UIButton *)sender
{
    
}

- (IBAction)backColoc:(UIButton *)sender
{
//    int i = arc4random() % 200;
    self.conterView.backgroundColor = [UIColor redColor];
}

@end
