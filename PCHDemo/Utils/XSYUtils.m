//
//  Utils.m
//  XSYParty
//
//  Created by xinshiyun on 16/3/23.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "XSYUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation XSYUtils

#pragma mark -正则匹配Email
+ (BOOL)isEmail:(NSString *)email {
    NSString *pattern = @"^[A-Za-z[0-9]]+([-_.][A-Za-z[0-9]]+)*@([A-Za-z[0-9]]+[-.])+[A-Za-z[0-9]]{2,4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

#pragma mark -正则匹配QQ
+ (BOOL)isQQ:(NSString *)qq {
    NSString *pattern = @"[1-9][0-9]{4,14}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:qq];
    return isMatch;
}

#pragma 正则匹配手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    if (mobileNum.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

#pragma 正则匹配用户密码6-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password {
    // @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}"   6-20字母数字组合
    // @"^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,18}$"   6-18位，英文字母、英文字符、数字组合（至少选2），区分大小写）
    // @"^[a-zA-Z0-9]{6,20}"    6-20位数字字母密码(纯数字,纯字母都可以)
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^[0-9]a-zA-Z]+$).{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma 正则匹配用户姓名,50位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName {
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
//    [\u4e00-\u9fa5]
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma mark -- 正则匹配用户姓名,10位的中文
+ (BOOL)checkChinaName:(NSString *)userName {
    NSString *pattern = @"^[\u4e00-\u9fa5]{1,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma mark -- 正则匹配用户职业,20位的中文英文和数字
+ (BOOL)checkJobName:(NSString *)userName {
    NSString *pattern = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位--粗略判断
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位--严格判断
+ (BOOL)checkIDCardNumber:(NSString *)idCard {
    idCard = [idCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([idCard length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:idCard]) {
        return NO;
    }
    int summary = ([idCard substringWithRange:NSMakeRange(0,1)].intValue + [idCard substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([idCard substringWithRange:NSMakeRange(1,1)].intValue + [idCard substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([idCard substringWithRange:NSMakeRange(2,1)].intValue + [idCard substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([idCard substringWithRange:NSMakeRange(3,1)].intValue + [idCard substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([idCard substringWithRange:NSMakeRange(4,1)].intValue + [idCard substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([idCard substringWithRange:NSMakeRange(5,1)].intValue + [idCard substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([idCard substringWithRange:NSMakeRange(6,1)].intValue + [idCard substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [idCard substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCard substringWithRange:NSMakeRange(8,1)].intValue *6
    + [idCard substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    
    return [checkBit isEqualToString:[[idCard substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url {
    NSString *pattern = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

/**
 *  根据网络地址获取视频缩略图
 *
 *  @param videoURL 视频地址
 *  @param time     截取时间
 *
 *  @return 返回缩略图
 */
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/** 在必填项前面设置* */
+ (NSMutableAttributedString *)setTextSpecialIdentifiy:(NSArray *)textArr withTextLocation:(NSIndexPath *)indexPath withTextString:(NSString *)textString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textArr[indexPath.row]];
    
    // 给"*"设立字体属性
    NSRange range1 = [textArr[indexPath.row] rangeOfString:@"*"];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                      NSForegroundColorAttributeName : [UIColor redColor],
                                      NSBaselineOffsetAttributeName : @(-2)
                                      } range:range1];
    
    // 给"-----"设立字体属性
    NSRange range2 = [textArr[indexPath.row] rangeOfString:textString];
    [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0],
                                      NSFontAttributeName : [UIFont systemFontOfSize:14],
                                      NSBaselineOffsetAttributeName : @2
                                      } range:range2];
    return attributedString;
}

#pragma mark -创建提醒视图
+ (void)warningView:(UIView *)superView withTitle:(NSString *)warnText withTextField:(UITextField *)textField {
    __block UILabel *warnLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 64+11, [UIScreen mainScreen].bounds.size.width-60, 44)];
    warnLabel.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
    warnLabel.layer.borderColor = [UIColor clearColor].CGColor;
    warnLabel.layer.borderWidth = 1;
    warnLabel.layer.masksToBounds = YES;
    warnLabel.layer.cornerRadius = 8;
    warnLabel.text = warnText;
    warnLabel.textColor = [UIColor whiteColor];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.font = [UIFont systemFontOfSize:14];
    warnLabel.adjustsFontSizeToFitWidth = YES;
    warnLabel.minimumScaleFactor = 12;
    warnLabel.alpha = 0.0;
    [superView addSubview:warnLabel];
    
    // 弹出键盘
    [textField becomeFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        warnLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            warnLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [warnLabel removeFromSuperview];
            
            warnLabel = nil;
        }];
    }];
}

#pragma mark - label高度自适应
+ (CGFloat)heightForString:(UILabel *)informationLabel andWidth:(float)width {
    CGSize sizeToFit = [informationLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    return sizeToFit.height;
}

#pragma mark -13位时间戳转时间
+ (NSString *)fomateString:(NSNumber *)dateNum {
    NSString * timeStampString = [dateNum stringValue];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [objDateformat stringFromDate:date];
    return dateString;
}

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

// 是否可以打开设置页面
+ (BOOL)canOpenSystemSettingView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return YES;
    } else {
        return NO;
    }
}

// 跳到系统设置页面
+ (void)openSystemSettingView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
