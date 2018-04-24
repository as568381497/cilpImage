//
//  GifUtils.h
//  gifmaker
//
//  Created by 张帆 on 2017/10/10.
//  Copyright © 2017年 adesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Photos;

typedef NS_ENUM(NSInteger, GifType) {
    GifFromVideo = 0,
    GifFromBurst,
    GifFromLivephoto,
    GifFromImgs,
    GifFromGif
};

@interface GifUtils : NSObject

/** 视频-->图片 将视频转为按指定间隔转成一组图片
 * avasset : 视频资源
 * interval : 每帧之间的间隔
 * block 返回所需的一组图片
 */
//+ (void)imgsWithVideoAsset:(AVAsset *)avasset withTimeInterval:(float)interval withTimeRange:(CMTimeRange)range completion:(void(^)(NSMutableArray *images))completionBlock;
//
///** 图片-->视频
// * images : 图片数组
// * targetSize : 视频尺寸
// */
//+ (void)videoWithImages:(NSArray *)images withCropSize:(CGSize)targetSize completion:(void(^)(NSURL *outurl))block;
//
///** livephoto-->视频
// * livephoto : livephoto
// *
// */
//+ (void)videoWithLivePhoto:(PHLivePhoto *)livePhoto Completion:(void (^)(NSURL* url))completionBlock;

/** 图片-->gif
 * images : 原材料
 * delay : 每一张图片停留的时间
 */
+ (void)gifWithImages:(NSArray *)images withDelay:(float)delay;

/** video-->gif
 * images : 原材料
 * delay : 每一张图片停留的时间
 */
//+ (void)gifWithVideo:(NSURL *)videoUrl withFrameCount:(int)frameCount delayTime:(float)delayTime loopCount:(int)loopCount completion:(void (^)(NSURL * gifUrl))completionBlock;

//新增
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

@end
