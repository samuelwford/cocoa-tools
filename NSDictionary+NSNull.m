//
//  NSDictionary+NSNull.m
//
//  Created by Samuel Ford on 2/4/13.
//

#import "NSDictionary+NSNull.h"

@implementation NSDictionary (NSNull)

- (id)nullSafeValueOfKey:(id)key {
    id value = self[key];
    return [[NSNull null] isEqual:value] ? nil : value;
}

@end
