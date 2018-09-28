//
//  Share.m
//  TomAR
//
//  Created by 绝非 on 2018/8/21.
//  Copyright © 2018年 绝非. All rights reserved.
//

#import "Share.h"
#import "WXApi.h"

@implementation Share

+(void)ShareImage:(NSString *)imageBase64 desc:(NSString *)desc isTimeline:(BOOL)isTimeline{
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [[UIImage alloc]initWithData:data];
    UIImage *thumb = [self compressImage:photo toByte:32768];
    
    /*分享图片*/
     WXMediaMessage *message = [WXMediaMessage message];
     // 设置消息缩略图的方法
     [message setThumbImage:thumb];

    
     WXImageObject *imageObject = [WXImageObject object];
     // 图片真实数据内容
     imageObject.imageData = data;
     // 多媒体数据对象，可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等。
     message.mediaObject = imageObject;
    
     SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
     req.bText = NO;
     req.message = message;
     req.scene = WXSceneTimeline;// 分享到朋友圈
     [WXApi sendReq:req];
    
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


@end
