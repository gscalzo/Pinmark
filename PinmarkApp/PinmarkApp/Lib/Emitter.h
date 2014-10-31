//
// Created by Giordano Scalzo on 02/07/2014.
// Copyright (c) 2014 Effective code. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Emitter : NSObject

- (void)subscribe:(id)observer on:(void (^)())observerBlock;
- (void)on:(id)observer onError:(void (^)(NSError *))observerErrorBlock;

- (void)emit;

- (void)unsubscribe:(id)observer;

- (void)emitError:(NSError *)error;
@end