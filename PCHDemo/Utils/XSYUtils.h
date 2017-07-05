//
//  Utils.h
//  XSYParty
//
//  Created by xinshiyun on 16/3/23.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XSYUtils : NSObject

/** 正则匹配email */
+(BOOL)isEmail:(NSString *)email;
/** 正则匹配QQ */
+(BOOL)isQQ:(NSString *)qq;
/** 正则匹配手机号 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/** 正则匹配用户密码6-20位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *)password;
/** 正则匹配用户姓名,20位的中文或英文 */
+ (BOOL)checkUserName:(NSString *)userName;
/** 正则匹配用户姓名,10位的中文 */
+ (BOOL)checkChinaName:(NSString *)userName;
/** 正则匹配用户职业,20位的中文英文和数字 **/
+ (BOOL)checkJobName:(NSString *)userName;
/** 正则匹配用户身份证号--粗略验证 */
+ (BOOL)checkUserIdCard:(NSString *)idCard;
/** 正则匹配用户身份证号--严格验证 */
+ (BOOL)checkIDCardNumber:(NSString *)idCard;
/** 正则匹员工号,12位的数字 */
+ (BOOL)checkEmployeeNumber:(NSString *)number;
/** 正则匹配URL */
+ (BOOL)checkURL:(NSString *)url;
/** 根据视频地址获取指定时间的视频截图 */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
/** 将json格式的字符串转换为字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/** 在必填项前面设置* */
+ (NSMutableAttributedString *)setTextSpecialIdentifiy:(NSArray *)textArr withTextLocation:(NSIndexPath *)indexPath withTextString:(NSString *)textString;
/** 创建提醒视图 */
+ (void)warningView:(UIView *)superView withTitle:(NSString *)warnText withTextField:(UITextField *)textField;
/** 动态计算UILabel高度自适应 */
+ (CGFloat)heightForString:(UILabel *)informationLabel andWidth:(float)width;
/** 13时间戳转时间 */
+ (NSString *)fomateString:(NSNumber *)dateNum;
/** 判断字符串是否全部为空格 */
+ (BOOL)isEmpty:(NSString *)str;
/** 是否可以打开设置页面 */
+ (BOOL)canOpenSystemSettingView;
/** 跳到系统设置页面 */
+ (void)openSystemSettingView;

@end
