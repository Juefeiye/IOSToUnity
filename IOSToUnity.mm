//
//  IOSToUnity.m
//  TomAR
//
//  Created by 绝非 on 2018/8/17.
//  Copyright © 2018年 绝非. All rights reserved.
//

#import "IOSToUnity.h"
#import "UnityInterface.h"
#import "Until.h"

@implementation IOSToUnity

//复制文本到剪切板；text：需要复制的文本
extern "C" void CopyToClipboard(const char *text)
{
    [[Until sharedInstance]copyToClipboard:[NSString stringWithUTF8String:text]];
    strdup(text);
}

//保存图片到相册；imageBase64: 图片的base64编码
//UnitySendMessage("GameMgr"," onSavePhotoAlbum", result)
extern "C" void SavePhotoAlbum(const char *imageBase64)
{
    [[Until sharedInstance] SavePhotoAlbum:[NSString stringWithUTF8String:imageBase64]];
    strdup(imageBase64);
}

//微信分享图片
// <param name=”shareJpg”>要分享的图片</param>
// <param name="desc">描述</param>
// <param name="isTimeline">分享至朋友圈/好友 true:朋友圈 false:好友</param>
extern "C" void ShareImage(const char * imageBase64,const char *desc,bool isTimeline)
{
    [[Until sharedInstance]ShareImage:[NSString stringWithUTF8String:imageBase64] desc:[NSString stringWithUTF8String:desc] isTimeline:isTimeline];
    strdup(imageBase64);
    strdup(desc);
}

//跳转设置权限的系统设置界面
extern "C" void GoSettingPage()
{
    [[Until sharedInstance]GoSettingPage];
}
    
@end
