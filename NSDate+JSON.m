//
//  NSDate+JSON.m
//
//  Created by Samuel Ford on 2/4/13.
//

#import "NSDate+JSON.h"

@implementation NSDate (JSON)

+ (NSDate *)dateFromJSONString:(NSString *)jsonString {
    if (jsonString == nil || [[NSNull null] isEqual:jsonString]) return nil;
    
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:jsonString options:0 range:NSMakeRange(0, [jsonString length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[jsonString substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [jsonString substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [jsonString substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [jsonString substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    
    return nil;
}

- (NSString *)JSON {
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss.sss"];
    });
    
    return [_dateFormatter stringFromDate:self];
}

@end
