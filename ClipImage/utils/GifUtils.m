//
//  GifUtils.m
//  gifmaker
//
//  Created by 张帆 on 2017/10/10.
//  Copyright © 2017年 adesk. All rights reserved.
//

#import "GifUtils.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSGIF.h"

@implementation GifUtils

//#pragma mark - 公开 video --> img
//+ (void)imgsWithVideoAsset:(AVAsset *)avasset withTimeInterval:(float)interval withTimeRange:(CMTimeRange)range completion:(void(^)(NSMutableArray *images))completionBlock {
//    NSMutableArray *resultImages = [NSMutableArray array];
//
//    if (interval <= 0) {
//        interval = 0.5;
//    }
//
//    CMTime cmDuration = avasset.duration;
//    int startSeconds = 0;
//
//    if (range.duration.value != 0) {
//        cmDuration = range.duration;
//        startSeconds = (int)(range.start.value / range.start.timescale);
//    }
//
//    float videoLength = (float)cmDuration.value / cmDuration.timescale;
//    NSUInteger frameCount = videoLength / interval;
//
//    //确定时间间隔
//    NSMutableArray *timePoints = [NSMutableArray array];
//    for (int i = 0; i<frameCount; i++) {
//        float point = i * interval + startSeconds;
//        CMTime curTime = CMTimeMakeWithSeconds(point, 600);
//        [timePoints addObject:[NSValue valueWithCMTime:curTime]];
//    }
//
//    if (timePoints.count == 0) {
//        completionBlock(nil);
//    }
//
//    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:avasset];
//    generator.appliesPreferredTrackTransform = YES;
//
//    generator.maximumSize = [SystemUtils sizeMaxWidth:MAX_PIXEL_VIDEOGIF withSize:avasset.naturalSize];
//    generator.requestedTimeToleranceAfter = kCMTimeZero;
//    generator.requestedTimeToleranceBefore = kCMTimeZero;
//
//    NSLock *locker = [[NSLock alloc] init];
//    __block NSUInteger blockCount = 0;
//    [generator generateCGImagesAsynchronouslyForTimes:timePoints completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
//
//        [locker lock];
//        blockCount ++;
//        if (result != AVAssetImageGeneratorSucceeded) {
//            NSLog(@"无法生成图片, error:%@", error);
//        }else {
//            UIImage *frameImg =[UIImage imageWithCGImage:image];
//            [resultImages addObject:frameImg];
//        }
//
//        if (blockCount == timePoints.count) {
//            completionBlock(resultImages);
//        }
//        [locker unlock];
//    }];
//
//    //    CGImageRef imageRef = [generator copyCGImageAtTime:[time CMTimeValue] actualTime:nil error:&error];
//}
//
//
//#pragma mark - 公开 img --> video
//+ (void)videoWithImages:(NSArray *)images withCropSize:(CGSize)targetSize completion:(void (^)(NSURL *))block {
//    targetSize = (targetSize.height=targetSize.width==0)? CGSizeMake(640, 640) : targetSize;
//
//    NSArray *imageArray = [SystemUtils newCroppedImagesWith:images withSize:targetSize];   //裁剪好的图片组
//    [SystemUtils deleteFileAtPath:PATH_VIDEO];
//    NSURL *exportUrl = [NSURL fileURLWithPath:PATH_VIDEO];
//    __block AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:exportUrl
//                                                                   fileType:AVFileTypeQuickTimeMovie
//                                                                      error:nil];
//
//    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
//                                   [NSNumber numberWithInt:targetSize.width], AVVideoWidthKey,
//                                   [NSNumber numberWithInt:targetSize.height], AVVideoHeightKey, nil];
//    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
//
//    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
//
//    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
//                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
//    NSParameterAssert(writerInput);
//    NSParameterAssert([videoWriter canAddInput:writerInput]);
//
//    if ([videoWriter canAddInput:writerInput])
//        NSLog(@"can write");
//    else
//        NSLog(@"can not write");
//
//    [videoWriter addInput:writerInput];
//    [videoWriter startWriting];
//    [videoWriter startSessionAtSourceTime:kCMTimeZero];
//
//    //合成多张图片为一个视频文件
//    dispatch_queue_t dispatchQueue = dispatch_queue_create("mediaInputQueue", NULL);
//    int __block frame = 0;
//
//    [writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
//        while ([writerInput isReadyForMoreMediaData]){
//            if(++frame > 8 * 30){   //完成写入
//                [writerInput markAsFinished];
//                if(videoWriter.status == AVAssetWriterStatusWriting){
//                    NSCondition *cond = [[NSCondition alloc] init];
//                    [cond lock];
//                    [videoWriter finishWritingWithCompletionHandler:^{
//                        [cond lock];
//                        [cond signal];
//                        [cond unlock];
//                    }];
//                    [cond wait];
//                    [cond unlock];
//                    !block?:block(exportUrl);
//                }
//                break;
//            }
//            //写入每一帧
//            CVPixelBufferRef buffer = NULL;
//            int idx = (int)(frame/30 * images.count/8);
//            if (idx >= images.count) {
//                idx = (int)images.count - 1;
//            }
//            buffer = (CVPixelBufferRef)[GifUtils pixelBufferFromCGImage:[[imageArray objectAtIndex:idx] CGImage] size:targetSize];
//            if (buffer){
//                if(![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frame, 30)]){
//                    NSLog(@"fail to append buffer");
//                }else{
////                    NSLog(@"success to appdend buffer :%ld", (long)frame);
//                }
//                CFRelease(buffer);
//            }
//        }
//    }];
//}
//
//#pragma mark - 公开 livephoto --> video
//+ (void)videoWithLivePhoto:(PHLivePhoto *)livePhoto Completion:(void (^)(NSURL* url))completionBlock {
//    if (@available(iOS 9.1, *)) {
//
//        NSURL *fileUrl = [NSURL fileURLWithPath:PATH_VIDEO];
//        [SystemUtils deleteFileAtPath:PATH_VIDEO];
//
//        if(livePhoto){
//            NSArray* assetResources = [PHAssetResource assetResourcesForLivePhoto:livePhoto];
//            PHAssetResource* videoResource = nil;
//            for(PHAssetResource* resource in assetResources){
//                if (resource.type == PHAssetResourceTypePairedVideo) {
//                    videoResource = resource;
//                    break;
//                }
//            }
//            if(videoResource){
//                [[PHAssetResourceManager defaultManager] writeDataForAssetResource:videoResource toFile:fileUrl options:nil completionHandler:^(NSError * _Nullable error) {
//                    if(!error){
//                        completionBlock(fileUrl);
//                    }else{
//                        completionBlock(nil);
//                    }
//                }];
//            }else{
//                completionBlock(nil);
//            }
//        }else{
//            completionBlock(nil);
//        }
//    }
//}

#pragma mark - 公开 img --> gif
+ (void)gifWithImages:(NSArray *)images withDelay:(float)delay {
    
    NSArray *cropedImgs = [self cropImgs:images];   //裁剪后的
    
    delay = delay<=0? 0.1f : delay;
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((CFURLRef)[NSURL fileURLWithPath:PATH_GIF], kUTTypeGIF, cropedImgs.count, NULL);
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @{(NSString *)kCGImagePropertyGIFDelayTime : @(delay)},
                                     (NSString *)kCGImagePropertyGIFDictionary , nil];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @{(NSString *)kCGImagePropertyGIFLoopCount : @(0)},
                                   (NSString *)kCGImagePropertyGIFDictionary , nil];
    for (UIImage *eachImg in cropedImgs) {
        CGImageDestinationAddImage(destination, eachImg.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)gifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
}

//#pragma mark - 公开 video --> gif
//+ (void)gifWithVideo:(NSURL *)videoUrl withFrameCount:(int)frameCount delayTime:(float)delayTime loopCount:(int)loopCount completion:(void (^)(NSURL *gifUrl))completionBlock {
//    
//    [NSGIF createGIFfromURL:videoUrl withFrameCount:frameCount delayTime:delayTime loopCount:loopCount completion:^(NSURL *GifURL) {
//        completionBlock(GifURL);
//    }];
//}


#pragma mark - 公开 以当前view 生成图片
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 私有方法

+ (CMSampleBufferRef)sampleBufferFromCGImage:(CGImageRef)image
{
    CVPixelBufferRef pixelBuffer = [GifUtils pixelBufferFromCGImage:image size:CGSizeMake(640, 640)];
    CMSampleBufferRef newSampleBuffer = NULL;
    CMSampleTimingInfo timimgInfo = kCMTimingInfoInvalid;
    CMVideoFormatDescriptionRef videoInfo = NULL;
    CMVideoFormatDescriptionCreateForImageBuffer(
                                                 NULL, pixelBuffer, &videoInfo);
    CMSampleBufferCreateForImageBuffer(kCFAllocatorDefault,
                                       pixelBuffer,
                                       true,
                                       NULL,
                                       NULL,
                                       videoInfo,
                                       &timimgInfo,
                                       &newSampleBuffer);
    
    return newSampleBuffer;
}

+ (CVPixelBufferRef )pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, size.width, size.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options, &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width, size.height, 8, 4*size.width, rgbColorSpace, kCGImageAlphaPremultipliedFirst);
    NSParameterAssert(context);
    //CGSize drawSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    //BOOL baseW = drawSize.width < drawSize.height;
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}


+ (NSArray *)cropImgs:(NSArray *)originImgs {
    
    if (originImgs.count == 0) {
        return nil;
    }
    
    UIImage *firstImg = [originImgs firstObject];
    float ratio = firstImg.size.height / firstImg.size.width; //长宽比
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (UIImage *origin in originImgs) {
        UIImage *cropedImg = [self cropImg:origin WithAspectRatio:ratio];
        [resultArr addObject:cropedImg];
    }
    return resultArr;
}

+ (UIImage *)cropImg:(UIImage *)originImg WithAspectRatio:(float)ratio {
    CGRect rect;
    
    float nowl = originImg.size.height / originImg.size.width;
    float tolerance = fabs(nowl - ratio);
    if (tolerance < 0.01) {
        return originImg;
    }
    
    if (ratio > nowl) {
        float width = originImg.size.height / ratio;
        float startX = (originImg.size.width - width) / 2;
        rect = CGRectMake(startX, 0, width, originImg.size.height);
        
    }else {
        float height = originImg.size.width * ratio;
        float startY = (originImg.size.height - height) / 2;
        rect = CGRectMake(0, startY, originImg.size.width, height);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([originImg CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}



@end
