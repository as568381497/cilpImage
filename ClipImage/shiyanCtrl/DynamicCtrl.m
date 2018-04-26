//
//  DynamicCtrl.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/25.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import "DynamicCtrl.h"
#import "GifUtils.h"

//@import FLAnimatedImage;
//@import SDWebImage;

@interface DynamicCtrl ()
@property (weak, nonatomic) IBOutlet UIView *conterView;

@property (retain, nonatomic)NSMutableArray *images;

@property (assign, nonatomic)NSUInteger conut;

@end

@implementation DynamicCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"4woso13" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    CGFloat width = self.conterView.frame.size.width/3;
    CGFloat height = self.conterView.frame.size.height/5;
    NSInteger y = 0;
    NSInteger x = 0;
//    for (int i = 0; i < 15; i++)
//    {
//
//        FLAnimatedImageView *view = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(x*width, y*height, width, height)];
//        view.animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
//        view.contentMode = UIViewContentModeScaleToFill;
//        [self.conterView addSubview:view];
//
//        x++;
//
//        if ((i+1) % 3 == 0)
//        {
//            y ++;
//        }
//
//        if (x>2)
//        {
//            x = 0;
//        }
//    }
    
}

- (IBAction)make:(UIButton *)sender
{
    self.images = [NSMutableArray array];
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
            weakSelf.conterView.hidden = YES;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:weakSelf.view.frame];
            imageView.contentMode = UIViewContentModeScaleToFill;
            UIImage *image = [UIImage animatedImageWithImages:weakSelf.images duration:1];
            imageView.image = image;
            [weakSelf.view addSubview:imageView];
            
        });
        
        return;
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *image = [GifUtils makeImageWithView:self.conterView withSize:self.conterView.frame.size];
        [self.images addObject:image];
        weakSelf.conut++;
    });
    
}

@end
