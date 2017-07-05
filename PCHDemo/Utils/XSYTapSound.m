//
//  BaseTapSound.m
//  IntegrationMediate
//
//  Created by 张兆卿 on 16/8/8.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "XSYTapSound.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface XSYTapSound() {
    SystemSoundID soundID;
    SystemSoundID systemSoundID;
}

@end

@implementation XSYTapSound

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(soundID);
}

static XSYTapSound *baseSound;
+ (instancetype)shareTapSound {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (baseSound == nil) {
            baseSound=[[self alloc]init];
            baseSound.vibrate = YES;
        }
    });
    return baseSound;
}

- (void)playSoundFileName:(NSString *)soundName {
    NSURL *url=[[NSBundle mainBundle]URLForResource:soundName withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
}

- (void)playSound {
    if (self.vibrate) {
        AudioServicesPlayAlertSound(soundID);
    } else {
        AudioServicesPlaySystemSound(soundID);
    }
}

- (void)playSystemSound {
    //系统声音
    AudioServicesPlaySystemSound(1007);
    if (self.vibrate) {
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

/**
 * 是否有权限使用系统相机
 */
+ (BOOL)ifCanUseSystemCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {

        NSLog(@"相机权限受限");
        return NO;
    }
    return YES;
}

/**
 * 是否有权限使用系统相册
 */
+ (BOOL)ifCanUseSystemPhoto {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        
        NSLog(@"相册权限受限");
        return NO;
    }
    return YES;
}

/**
 * 是否有权限使用麦克风
 */
+ (BOOL)ifCanUseSystemMicrophone {
    __block BOOL bCanRecord = YES;
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [avSession requestRecordPermission:^(BOOL available) {
            if (available) {
                bCanRecord = YES;
            } else {
                bCanRecord = NO;
            }
        }];
    }
    return bCanRecord;
}

/**
 * 后置摄像头是否可用.
 */
+(BOOL)isCameraRearDeviceAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

/**
 * 前置摄像头是否可用.
 */
+(BOOL)isCameraFrontDeviceAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

@end
