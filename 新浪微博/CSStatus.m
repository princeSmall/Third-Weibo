//
//  CSStatus.m
//  新浪微博
//
//  Created by 童乐 on 15/11/7.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatus.h"
#import "MJExtension.h"
#import "CSPhoto.h"
@implementation CSStatus

/**
 *  数组里放的是模型，而不是字典
 *
 *  @return 
 */
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls":[CSPhoto class]};
}
/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */
- (NSString *)created_at {
 
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式（声明字符串里面每个数字和单词的含义）
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy

    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //微博创建时间
    NSDate *createdDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createdDate toDate:now options:0];
    
    if ([self isThisYear:createdDate]) { //今年
        if ([self isYesteday:createdDate]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdDate];
        }else if([self isTodday:createdDate]) {
            if (cmps.hour>=1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            } else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];

            } else {
                return @"刚刚";
            }
            
        } else { //今年的其他日期
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            return [fmt stringFromDate:createdDate];
        }
        
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    return _created_at;
}
/**
 *  判断某个时间是否为今年
 *
 *  @param date
 *
 *  @return
 */
- (BOOL) isThisYear:(NSDate *) date {
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    //获得某个时间的年月日时分秒
    NSDateComponents * dateCmps = [calendar components:unit fromDate:date];
    NSDateComponents * nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return dateCmps.year = nowCmps.year;

}
/**
 *  判断某个时间是否为昨天
 *
 *  @param date
 *
 *  @return
 */
- (BOOL) isYesteday:(NSDate *) date {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //yyyy-MM-dd
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
   //yyyy-MM-dd 00:00:00
    date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
/**
 *  判断某个时间是否为今天
 *
 *  @param date
 *
 *  @return
 */
- (BOOL) isTodday:(NSDate *) date {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //yyyy-MM-dd
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    //yyyy-MM-dd 00:00:00
    date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    return  [dateStr isEqualToString:nowStr];
}
- (void)setSource:(NSString *)source {
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
}
@end
