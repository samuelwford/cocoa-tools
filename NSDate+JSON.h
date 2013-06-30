//
//  NSDate+JSON.h
//
//  Created by Samuel Ford on 2/4/13.
//

#import <Foundation/Foundation.h>

@interface NSDate (JSON)

+ (NSDate *)dateFromJSONString:(NSString *)jsonString;

- (NSString *)JSON;

@end
