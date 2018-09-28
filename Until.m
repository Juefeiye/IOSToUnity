//
//  Until.m
//  TomAR
//
//  Created by 绝非 on 2018/8/20.
//  Copyright © 2018年 绝非. All rights reserved.
//

#import "Until.h"
#import "Share.h"
#import "NSString+ex.h"

@implementation Until

static Until* instance = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Until alloc]init];
        instance.photos = @[].mutableCopy;
    });
    return instance;
}


-(void)SavePhotoAlbum:(NSString *)imageBase64{
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [[UIImage alloc]initWithData:data];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contexInfo:), (__bridge void *)self);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contexInfo:(void *)contextInfo {
    NSString *result = nil;
    if (error) {
        result = @"false";
        NSLog(@"%@",error);
    }else{
        result = @"success";
    }
    //回调unity方法
    UnitySendMessage("GameMgr", "onSavePhotoAlbum", result.UTF8String);
}

-(void)copyToClipboard:(NSString *)text{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}

-(void)GoSettingPage{
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];
}

-(void)ShareImage:(NSString *)imageBase64 desc:(NSString *)desc isTimeline:(BOOL)isTimeline{
    [Share ShareImage:imageBase64 desc:desc isTimeline:isTimeline];
}

@end
