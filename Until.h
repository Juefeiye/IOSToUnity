//
//  Until.h
//  TomAR
//
//  Created by 绝非 on 2018/8/20.
//  Copyright © 2018年 绝非. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Until : NSObject
+ (instancetype)sharedInstance;
-(void)SavePhotoAlbum:(NSString *)imageBase64;
-(void)copyToClipboard:(NSString *)text;
-(void)GoSettingPage;
-(void)ShareImage:(NSString *)imageBase64 desc:(NSString *)desc isTimeline:(BOOL)isTimeline;
@end
