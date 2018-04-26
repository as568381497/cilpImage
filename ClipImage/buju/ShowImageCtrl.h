//
//  ShowImageCtrl.h
//  ClipImage
//
//  Created by pathfinder on 2018/4/26.
//  Copyright © 2018年 pathfinder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, showType) {
    showOne = 0,
    showTwo,
    showThree,
    showFour,
    showFive,
    showSix,
    showSeven
};

@interface ShowImageCtrl : UIViewController

@property (assign, nonatomic)showType type;

@end
