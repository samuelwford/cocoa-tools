//
//  SemanticVersionNumber.m
//
//  Created by Samuel Ford on 6/14/13.
//

#import "SemanticVersionNumber.h"

@implementation SemanticVersionNumber 

+ (SemanticVersionNumber *)numberFromString:(NSString *)string {
    NSMutableArray *splitNumbers = [NSMutableArray arrayWithCapacity:4];
    for (NSString *number in [string componentsSeparatedByString:@"."]) {
        [splitNumbers addObject:@([number integerValue])];
    }
    return [[SemanticVersionNumber alloc] initWithNumbers:splitNumbers];
}

- (id)initWithNumbers:(NSArray *)array {
    if ((self = [super init])) {
        _numbers = [array copy];
    }
    return self;
}

- (NSComparisonResult)compareTo:(SemanticVersionNumber *)version {
    BOOL theyAreEqualSoFar = YES;
    BOOL thatVersionIsGreater = NO;
    
    for (int i = 0; i < self.numbers.count; i++) {
        
        if (i > version.numbers.count - 1) {
            theyAreEqualSoFar = NO;
            thatVersionIsGreater = NO;
            break;
        }
        
        NSInteger myDigit = [self.numbers[i] integerValue];
        NSInteger theirDigit = [version.numbers[i] integerValue];
        
        if (myDigit > theirDigit) {
            theyAreEqualSoFar = NO;
            thatVersionIsGreater = NO;
            break;
        }
        
        if (theirDigit > myDigit) {
            theyAreEqualSoFar = NO;
            thatVersionIsGreater = YES;
            break;
        }
    }
    
    if (theyAreEqualSoFar && version.numbers.count > self.numbers.count) {
        thatVersionIsGreater = YES;
    }
    
    return theyAreEqualSoFar ? NSOrderedSame : thatVersionIsGreater ? NSOrderedDescending : NSOrderedAscending;
}

- (BOOL)isLessThanOrEqualTo:(SemanticVersionNumber *)version {
    return [self compareTo:version] != NSOrderedAscending;
}

- (BOOL)isGreaterThan:(SemanticVersionNumber *)version {
    return [self compareTo:version] == NSOrderedAscending;
}

- (NSString *)description {
    return [_numbers componentsJoinedByString:@"."];
}

@end
