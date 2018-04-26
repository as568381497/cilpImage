//
//  MainCtrl.m
//  ClipImage
//
//  Created by pathfinder on 2018/4/26.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import "MainCtrl.h"
#import "ShowImageCtrl.h"

#define STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface MainCtrl ()

@end

@implementation MainCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)goShowCtrl:(UIButton *)sender
{
    ShowImageCtrl *ctel = [STORYBOARD instantiateViewControllerWithIdentifier:NSStringFromClass([ShowImageCtrl class])];
    
    if ([sender.titleLabel.text isEqualToString:@"布局一"])
    {
        ctel.type = showOne;
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"布局二"])
    {
        ctel.type = showTwo;
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"布局三"])
    {
        ctel.type = showThree;
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"布局四"])
    {
        ctel.type = showFour;
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"布局五"])
    {
        ctel.type = showFive;
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"布局六"])
    {
        ctel.type = showSix;
    }
    
    [self.navigationController pushViewController:ctel animated:YES];
}

@end
