//
//  Baton.h
//
//  Created by Samuel Ford on 2/7/13.
//

#import <Foundation/Foundation.h>

typedef void(^BatonCompletionBlock)(BOOL cancelled);

@interface Baton : NSObject

+ (Baton *)batonWithName:(NSString *)name completion:(BatonCompletionBlock)block;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BatonCompletionBlock completion;

- (void)pass;
- (void)finish;
- (void)cancel;

- (BOOL)isCancelled;

@end
