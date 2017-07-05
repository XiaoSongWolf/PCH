//
//  BaseTapSound.h
//  IntegrationMediate
//
//  Created by 张兆卿 on 16/8/8.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//  播放音效类、判断应用是否有权限使用相机

#import <Foundation/Foundation.h>

@interface XSYTapSound : NSObject

/** 振动效果,默认为YES(有振动效果) */
@property(nonatomic) BOOL vibrate;
/** 音效播放对象 */
+ (instancetype)shareTapSound;
/** 添加音效文件 */
- (void)playSoundFileName:(NSString *)soundName;
/** 播放音效文件 */
- (void)playSound;
/** 播放系统音效 */
- (void)playSystemSound;
/** 是否有权限使用系统相机 */
+ (BOOL)ifCanUseSystemCamera;
/** 是否有权限使用系统相册 */
+ (BOOL)ifCanUseSystemPhoto;
/** 是否有权限使用麦克风 */
+ (BOOL)ifCanUseSystemMicrophone;
/** 后置摄像头是否可用 */
+ (BOOL)isCameraRearDeviceAvailable;
/** 前置摄像头是否可用 */
+ (BOOL)isCameraFrontDeviceAvailable;

@end
