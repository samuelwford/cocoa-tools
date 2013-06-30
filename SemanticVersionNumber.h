//
//  SemanticVersionNumber.h
//
//  Created by Samuel Ford on 6/14/13.
//

#import <Foundation/Foundation.h>

@interface SemanticVersionNumber : NSObject

@property (nonatomic, readonly) NSArray *numbers;

+ (SemanticVersionNumber *)numberFromString:(NSString *)string;

- (BOOL)isLessThanOrEqualTo:(SemanticVersionNumber *)version;

- (BOOL)isGreaterThan:(SemanticVersionNumber *)version;

@end
