//
//  Baton.m
//
//  Created by Samuel Ford on 2/7/13.
//

#import "Baton.h"
#import <libkern/OSAtomic.h>

@implementation Baton {
    volatile int32_t _passes;
    BOOL _cancelled;
}

+ (Baton *)batonWithName:(NSString *) name completion:(BatonCompletionBlock)block {
    Baton *b = [[Baton alloc] init];
    b.name = name;
    b.completion = block;
    return b;
}

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _passes = 0;
    _cancelled = NO;
    
    return self;
}

- (void)pass {
    OSAtomicIncrement32(&_passes);
    CVLog(@"%@ Baton Passed (%d)", self.name, _passes);
}

- (void)finish {
    OSAtomicDecrement32(&_passes);
    CVLog(@"%@ Baton Finished (%d)", self.name, _passes);
    
    if (_passes == 0) {
        CVLog(@"%@ Baton Calling Completion Block", self.name);
        self.completion(_cancelled);
    }
}

- (void)cancel {
    _cancelled = YES;
    [self finish];
}

- (BOOL)isCancelled {
    return _cancelled;
}

@end
