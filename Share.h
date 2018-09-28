//
//  Share.h
//  TomAR
//
//  Created by 绝非 on 2018/8/21.
//  Copyright © 2018年 绝非. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Share : NSObject
+(void)ShareImage:(NSString *)imageBase64 desc:(NSString *)desc isTimeline:(BOOL)isTimeline;
@end
